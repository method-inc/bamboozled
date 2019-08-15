# Implement endpoints for Bamboo HR's Applicant Tracking System
# https://www.bamboohr.com/api/documentation/ats.php
module Bamboozled
  module API
    class ApplicantTracking < Base
      APPLICATION_STATUS_GROUPS = %w[ALL ALL_ACTIVE NEW ACTIVE INACTIVE HIRED].freeze

      JOB_STATUS_GROUPS = [
        "ALL", "DRAFT_AND_OPEN", "Open", "Filled", "Draft", "Deleted", "On Hold", "Canceled"
      ].freeze

      # Get a list of job summaries -- GET /jobs
      def job_summaries(params = {}) # rubocop:disable Style/OptionHash
        query = {
          "statusGroups": "ALL",     # JOB_STATUS_GROUPS
          "sortBy":       "created", # "count", "title", "lead", "created", "status"
          "sortOrder":    "ASC"      # "ASC", "DESC"
        }.merge(params)

        request(:get, "applicant_tracking/jobs", query: query)
      end

      # Get a list of applications, following pagination -- GET /applications
      def applications(params = {}) # rubocop:disable Style/OptionHash
        page_limit = params.delete(:page_limit) { 1 }

        applications_array = []
        1.upto page_limit do |i|
          response = request_applications(params.merge(page: i))
          applications_array += response["applications"]
          break if response["paginationComplete"]
        end
        applications_array
      end

      # Get the details of an application -- GET /applications/:id
      def application(applicant_id)
        request(:get, "applicant_tracking/applications/#{applicant_id}")
      end

      # Add comments to an application -- POST /applications/:id/comments
      def add_comment(applicant_id, comment)
        details = { type: "comment", comment: comment }.to_json
        options = { body: details, headers: { "Content-Type" => "application/json" } }

        request(:post, "applicant_tracking/applications/#{applicant_id}/comments", options)
      end

      # Get a list of statuses for a company -- GET /statuses
      def statuses
        request(:get, "applicant_tracking/statuses")
      end

      # Change applicant's status -- POST /applications/:id/status
      def change_status(applicant_id, status_id)
        details = { status: status_id.to_i }.to_json
        options = { body: details, headers: { "Content-Type" => "application/json" } }

        request(:post, "applicant_tracking/applications/#{applicant_id}/status", options)
      end

      protected

      def request_applications(params = {}) # rubocop:disable Style/OptionHash
        # Also supported:
        # page, jobId, applicationStatusId, applicationStatus (APPLICATION_STATUS_GROUPS),
        # jobStatusGroups (JOB_STATUS_GROUPS), searchString
        query = {
          "sortBy":    "created_date", # "first_name", "job_title", "rating", "phone", "status", "last_updated", "created_date"
          "sortOrder": "ASC"           # "ASC", "DESC"
        }.merge(params)

        request(:get, "applicant_tracking/applications", query: query)
      end
    end
  end
end
