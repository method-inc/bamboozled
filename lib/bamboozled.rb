require 'httparty'
require 'json'
require 'uri'

Dir[File.dirname(__FILE__) + '/bamboozled/*.rb'].each do |file|
  require file
end

module Bamboozled
end
