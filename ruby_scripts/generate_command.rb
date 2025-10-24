#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

class CommandGenerator
  def initialize(command_name, namespace)
    @command_name = command_name
    @namespace = namespace.downcase
    @namespace_class = namespace.split('_').map(&:capitalize).join
    @class_name = command_name.split('_').map(&:capitalize).join
    @base_dir = '/Users/daviddavis/Desktop/boldpenguin/partner-engine'
  end

  def generate
    # Change to partner-engine directory
    unless Dir.exist?(@base_dir)
      puts "❌ Error: Partner Engine directory not found at #{@base_dir}"
      exit 1
    end

    Dir.chdir(@base_dir) do
      unless File.exist?('Gemfile') && Dir.exist?('app/commands')
        puts "❌ Error: Not in a valid partner-engine directory"
        exit 1
      end

      create_command_file
      create_response_file
      create_yml_files
      create_test_files

      puts "✅ Generated files for '#{@command_name}' command in '#{@namespace}' namespace:"
      puts "   - Command: app/commands/carrier_engine/#{@namespace}/#{@command_name}_command.rb"
      puts "   - Response: app/responses/carrier_engine/#{@namespace}/#{@command_name}_response.rb"
      puts "   - YML file: lib/data/response_paths/#{@namespace}/#{@command_name}_response.yml"
      puts "   - Test files in test/"
    end
  end

  private

  def create_command_file
    command_dir = "app/commands/carrier_engine/#{@namespace}"
    FileUtils.mkdir_p(command_dir)

    command_content = <<~RUBY
      # frozen_string_literal: true

      module CarrierEngine
        module #{@namespace_class}
          class #{@class_name}Command < JsonCommand
            attr_reader :url, :response_class

            # @param client [{@namespace_class}::Client]
            # @param carrier [Tenant]
            # @param store [#{@namespace_class}::#{@class_name}]
            def initialize(client:, carrier:, store:)
              super

              @url = '/create_application'
              @response_class = #{@class_name}Response
            end

            def facade
              @facade ||=
                carrier.facade_class.new(store.answer_map_with_pools, parent: store)
            end
          end
        end
      end
    RUBY

    File.write("#{command_dir}/#{@command_name}_command.rb", command_content)
  end

  def create_response_file
    response_dir = "app/responses/carrier_engine/#{@namespace}"
    FileUtils.mkdir_p(response_dir)

    response_content = <<~RUBY
      # frozen_string_literal: true

      module CarrierEngine
        module #{@namespace_class}
          class #{@class_name}Response < JsonResponse
            class << self
              def response_paths
                @response_paths ||= YAML.ext_load_file(
                  Rails.root.join(
                    *%w[lib data response_paths blitz #{@command_name}_response.yml]
                  ).to_s
                ).deep_symbolize_keys
              end
            end

            private

          # @return [Array<MetaError>]
            def base_errors
              [invalid_response_error + parsed_errors].flatten.compact_blank
            end

            # @return [Array<MetaError>]
            def invalid_response_error
              return [] if status == 200

              [
                build_error(
                  title: 'InvalidResponseStatus',
                  description:
                  "An unexpected response status was received for #{self.class}"
                )
              ]
            end

            # Blitz can return errors in both error_message and error_details
            # error details is referenced as an object, but I can't find
            # any examples of it being returned that way only as strings.
            # @return [Array<MetaError>]
            def parsed_errors
              return [] if successful?
            end
          end
        end
      end
    RUBY

    File.write("#{response_dir}/#{@command_name}_response.rb", response_content)
  end

  def create_yml_files
    yml_dir = "lib/data/response_paths/#{@namespace}"
    FileUtils.mkdir_p(yml_dir)

    # Create response YML file
    response_yml_content = <<~YAML
      # #{@command_name} response mapping configuration for #{@namespace}
      success:
        data:
          # Add success response mappings here

      error:
        error_message: "error"
        # Add error response mappings here
    YAML

    File.write("#{yml_dir}/#{@command_name}_response.yml", response_yml_content)
  end

  def create_test_files
    # Command test (MiniTest)
    command_test_dir = "test/commands/carrier_engine/#{@namespace}"
    FileUtils.mkdir_p(command_test_dir)

    command_test_content = <<~RUBY
      # frozen_string_literal: true

      require 'test_helper'

        module CarrierEngine
          module #{@namespace_class}
            class #{@class_name}CommandTest < ActiveSupport::TestCase
              def setup
                @command = CarrierEngine::#{@namespace_class}::#{@class_name}Command.new
              end

              test "should return successful response" do
                result = @command.call

                assert_instance_of CarrierEngine::#{@namespace_class}::#{@class_name}Response, result
                assert result.success?
              end

              test "should handle error cases" do
                # TODO: Add test cases for error scenarios
                skip "Add error test cases"
              end

              test "should validate required parameters" do
                # TODO: Add parameter validation tests
                skip "Add parameter validation tests"
              end
            end
          end
        end
      end
    RUBY

    File.write("#{command_test_dir}/#{@command_name}_command_test.rb", command_test_content)

    # Response test (MiniTest)
    response_test_dir = "test/responses/carrier_engine/#{@namespace}"
    FileUtils.mkdir_p(response_test_dir)

    response_test_content = <<~RUBY
      # frozen_string_literal: true

      require 'test_helper'

        module CarrierEngine
          module #{@namespace_class}
            class #{@class_name}ResponseTest < ActiveSupport::TestCase
              test "should initialize with success response" do
                response = CarrierEngine::#{@namespace_class}::#{@class_name}Response.new(
                  success: true,
                  data: { id: 123 }
                )

                assert response.success?
                assert_equal({ id: 123 }, response.data)
                assert_nil response.error
              end
            end
          end
        end
      end
    RUBY

    File.write("#{response_test_dir}/#{@command_name}_response_test.rb", response_test_content)
  end
end

# Run the generator
if ARGV.length != 2
  puts "Usage: ruby generate_command.rb <command_name> <namespace>"
  exit 1
end

command_name = ARGV[0]
namespace = ARGV[1]
generator = CommandGenerator.new(command_name, namespace)
generator.generate