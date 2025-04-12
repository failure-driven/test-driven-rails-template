# frozen_string_literal: true

module Pages
  class DemoPage < SitePrism::Page
    set_url Rails.application.routes.url_helpers.demo_path

    element :rails_link, "a[data-testid=rails_link]"
    element :html_input, "input[data-testid=html_input]"
    element :rails_button, "button[data-testid=rails_button]"
    element :rails_form, "input[data-testid=rails_form]"
    element :view_component, "a[data-testid=view_component]"

    sections :link_sections, "section[data-testid|=section]" do
      element :text, "p"
    end
  end
end
