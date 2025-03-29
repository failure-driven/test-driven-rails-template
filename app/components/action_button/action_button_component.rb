# frozen_string_literal: true

module ActionButton
  class ActionButtonComponent < ViewComponent::Base
    def initialize(label:, action_url:, icon:, method: nil, link_class: "")
      super
      @action_url = action_url
      @icon_class = "fad #{icon}"
      @label = label
      @class = link_class
      disable_with = []
      disable_with << tag.span(tag.i("", class: "fad fa-sync fa-spin"), class: "inline-block mr-2 w-4")
      disable_with << @label
      @method = method || :get
      @data = {
        disable: true,
        "disable-with": safe_join(disable_with)
      }
    end
  end
end
