require "spec_helper"

RSpec.describe "ApplicantTracking" do
  before do
    @client = Bamboozled.client(subdomain: "x", api_key: "x")
  end

  it "gets job summaries" do
    response = File.new("spec/fixtures/job_summaries.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    jobs = @client.applicant_tracking.job_summaries

    expect(jobs).to be_a Array
    expect(jobs.count).to eq 5
  end

  it "gets applicant statuses" do
    response = File.new("spec/fixtures/applicant_statuses.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    statuses = @client.applicant_tracking.statuses

    expect(statuses).to be_a Array
    expect(statuses.count).to eq 19
  end

  it "gets a list of applications" do
    response = File.new("spec/fixtures/applications.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    applications = @client.applicant_tracking.applications(page_limit: 10)

    expect(applications).to be_a Array
    expect(applications.count).to eq 13
  end

  it "gets details of an application" do
    response = File.new("spec/fixtures/application.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    application = @client.applicant_tracking.application(33)
    required_email = "nathan@efficientoffice.com"

    expect(application).to be_a Hash
    expect(application["applicant"]["email"]).to eq required_email
  end

  it "can change the status of an application" do
    response = File.new("spec/fixtures/change_applicant_status.json")
    stub_request(:post, /.*api\.bamboohr\.com.*/).to_return(response)

    status_change = @client.applicant_tracking.change_status(33, 3)

    expect(status_change).to be_a Hash
    expect(status_change["type"]).to eq "positionApplicantStatus"
  end

  it "can add a comment to an application" do
    response = File.new("spec/fixtures/application_comment.json")
    stub_request(:post, /.*api\.bamboohr\.com.*/).to_return(response)

    comment = @client.applicant_tracking.add_comment(33, "Test comment")

    expect(comment).to be_a Hash
    expect(comment["type"]).to eq "comment"
  end
end
