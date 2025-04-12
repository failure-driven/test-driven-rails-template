# frozen_string_literal: true

RSpec.describe ActionButtonComponent, type: :component do
  it "renders an action button", :aggregate_failures do
    render_inline(
      ActionButtonComponent.new(
        label: "some label",
        action_url: "some-url",
        icon: "some-icon",
        data: {
          testid: "some-data-testid",
        },
      ),
    )

    # NOTE: to view the page you can `page.native.to_html`
    expect(page).to have_css "a[data-testid=some-data-testid]", text: "some label"
    expect(page.find("i")["class"]).to have_content "some-icon"
  end
end
