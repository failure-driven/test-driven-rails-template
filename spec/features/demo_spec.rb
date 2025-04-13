# frozen_string_literal: true

RSpec.feature "Demo a number of ideas", :js do
  let(:demo_page) { Pages::DemoPage.new }

  scenario "Demo a number of demo links and buttons" do
    When "the the demo page is visited" do
      demo_page.load
    end

    Then "there are 5 different button sections" do
      expect(
        demo_page.link_sections.map { |x| x.text.text },
      ).to eq([
        "a basic link via rails link_to",
        "a plain HTML input tag of type=\"button\"",
        "a rails button_tag",
        "A rails form_for with a submit inside",
        "A rails form_for with a submit inside with enabled/disabled styling",
        "A view_componewnt action_button using stimulus",
        "A stimulus component",
        "A react component",
      ])
    end

    When "the rails link is clicked" do
      demo_page.rails_link.click
    end

    Then "the page is reloaded" do
      expect(page).to have_current_path(demo_path)
    end

    When "the html input is clicked" do
      demo_page.html_input.click
    end

    Then "the page is reloaded" do
      expect(page).to have_current_path(demo_path)
    end

    When "the rails button is clicked" do
      demo_page.rails_button.click
    end

    Then "the page is reloaded" do
      expect(page).to have_current_path(demo_path)
    end

    When "the rails form is submitted" do
      demo_page.rails_form.click
    end

    Then "the page is reloaded" do
      expect(page).to have_current_path(demo_path(commit: "Demos"))
    end

    When "the rails form loading is submitted" do
      demo_page.rails_form_loading.click
    end

    Then "the page is reloaded" do
      expect(page).to have_current_path(demo_path(commit: "Demos"))
    end

    When "the view_component action button is clicked" do
      demo_page.view_component.click
    end

    Then "the page is reloaded" do
      expect(page).to have_current_path(demo_path)
    end

    When "the sitmulus component is clicked" do
      demo_page.stimulus_component.click
    end

    Then "the page is reloaded" do
      expect(page).to have_current_path(demo_path)
    end

    When "the react component is clicked" do
      demo_page.react_component.click
    end

    Then "the page is reloaded" do
      expect(page).to have_current_path(demo_path)
    end
  end
end
