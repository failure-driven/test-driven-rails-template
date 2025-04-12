# frozen_string_literal: true

module Pages
  module Helpers
    module FormsHelper
      SETTABLE_ELEMENTS = ["datetime-local", "checkbox"].freeze

      def self.[](action, model)
        Module.new do
          extend ActiveSupport::Concern

          included do
            define_method(:get_action) do
              action
            end
            define_method(:get_model) do
              model
            end

            def fill_in(**args)
              args.each do |field, value|
                element = find(
                  "form[action^=\"#{get_action}\"] " \
                  "input[name=\"#{get_model}[#{field}]\"],textarea[name=\"#{get_model}[#{field}]\"]",
                )
                if SETTABLE_ELEMENTS.include? element[:type]
                  element.set(value)
                else
                  element.fill_in(with: value)
                end
              end
            end

            def submit!(...)
              fill_in(...)
              find("form[action^=\"#{get_action}\"] input[type=submit],button[type=submit]").click
            end
          end
        end
      end
    end
  end
end
