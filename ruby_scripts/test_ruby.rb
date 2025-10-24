module CarrierEngine
  module #{@namespace_class}
    class #{@class_name}Command < BaseCommand
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