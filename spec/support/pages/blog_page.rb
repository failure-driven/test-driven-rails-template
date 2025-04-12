# frozen_string_literal: true

module Pages
  class BlogPage < SitePrism::Page
    # set_url Rails.application.routes.url_helpers.blogs_path
    set_url "/blogs"

    include Helpers::FormsHelper[
      "/blogs", # Rails.application.routes.url_helpers.blogs_path,
      "blog" # Blog.name.underscore
    ]

    element :new_blog, "a", text: "New blog"
    element :edit_blog, "a", text: "Edit this blog"
    element :view_blogs, "a", text: "Back to blogs"
    element :destroy_blog, "button[type=submit]", text: "Destroy this blog"

    element :blog_title, "[id^=blog_] p", text: "Title:"
    element :body, "[id^=blog_] p", text: "Body:"
    element :author, "[id^=blog_] p", text: "Author:"

    sections :posts, "div#blogs div[id^=blog_]", wait: 0 do
      element :blog_text, "p"
    end

    def notification
      # NOTE: rails success messge is
      #   <p style=\"color: green\">Blog was successfully created.</p>
      # Presumably failure message is
      #   <p style=\"color: red\">Unprocessable operation.</p>
      find_all("p").first.text
    end

    def posts_text
      posts.map { _1.text }
    end

    def show_blog!(number)
      page.find_all("a", text: "Show this blog")[number - 1].click
    end
  end
end
