require 'fileutils'
require 'pry'

# Ensure the script is run from the specified directory
required_directory = '/Users/daviddavis/Desktop/boldpenguin/carrier-engine'
current_directory = Dir.pwd

if ARGV.empty?
  puts "Usage: ruby refresh_system_tests.rb <carrier>"
  exit 1
end

carrier = ARGV[0]

unless current_directory == required_directory
  puts "Changing directory to #{required_directory}"
  Dir.chdir(required_directory)
end

# Directory to search
directory = "./test/seeds/application_forms"
carrier_files = Dir.glob("#{directory}/*.json")

# Iterate over each CNA YML file and run the rake task
carrier_files.reject { |x| !x.include?('cna') }.each do |file|
  puts "Refreshing System Tests :: #{file}\n"
  system("rake #{file[2..-1]}")
  puts "\n"
end


puts "========================================================"
puts "Completed refreshing system tests for #{carrier}\n"
puts "========================================================\n\n"