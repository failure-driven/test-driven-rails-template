# frozen_string_literal: true

RSpec.describe ReactComponent, type: :component do
  it "renders a react component", :aggregate_failures do
    render_inline(
      ReactComponent.new(
        component_name: "SomeReactComponent",
        data: {
          props: {
            fooProp: "foo prop",
            barProp: "bar prop",
          },
        },
      ),
    )

    # NOTE: to view the page you can `page.native.to_html`
    div_element = page.find("div")
    expect(div_element["class"]).to eq "react-SomeReactComponent"
    expect(div_element["data-testid"]).to eq "react-SomeReactComponent"
    expect(div_element["data-props"]).to eq "{\"fooProp\":\"foo prop\",\"barProp\":\"bar prop\"}"
  end
end
