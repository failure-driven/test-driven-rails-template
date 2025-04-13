# frozen_string_literal: true

class ReactComponent < ViewComponent::Base
  def initialize(component_name:, data: {})
    @data_attrs = {
      testid: "react-#{component_name}",
      react_component: component_name,
      props: {},
    }.merge(data)
    @class_name = "react-#{component_name}"
  end
end
