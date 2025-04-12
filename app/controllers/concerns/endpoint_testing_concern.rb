# frozen_string_literal: true

# include in the ApplicationController
# class ApplicationController < ActionController::Base
#   include ::EndpointTestingConcern
# end
#
# to be able to pause or error an API in specs
#   When "the sitmulus component is clicked and fetching" do
#     with_api_route_paused(method: :GET, url: demo_path) do
#       demo_page.stimulus_component.click
#       expect(demo_page.stimulus_component.text).to eq "fetching ..."
#     end
#   end

module EndpointTestingConcern
  extend ActiveSupport::Concern

  included do
    before_action :forced_api_error, unless: -> { Rails.env.production? }
    before_action :pause_execution, unless: -> { Rails.env.production? }

    private

    def forced_api_error
      raise Rails.application.config.send(:should_crash)[:error] if disrupt_with?(:should_crash)
    end

    def pause_execution
      Kernel.sleep 0.2 while disrupt_with?(:should_pause)
    end

    def disrupt_with?(method)
      should_disrupt_route_config = Rails.application.config.respond_to?(method) &&
        Rails.application.config.send(method)

      return unless should_disrupt_route_config

      request_for_method_url?(
        method: should_disrupt_route_config[:method],
        url: should_disrupt_route_config[:url],
      )
    end

    def request_for_method_url?(method:, url:)
      method.to_s.downcase.casecmp?(request.method.downcase) &&
        request.url.include?(url)
    end
  end
end
