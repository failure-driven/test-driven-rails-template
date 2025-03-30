# frozen_string_literal: true

# NOTE: Demonstration of how to use features. This spec can be made passing
#       using a rails scaffold
#
#   bin/rails \
#     generate scaffold Blog \
#     title:string \
#     body:text \
#     author:string \
#     --skip-helper \
#     --test-framework rspec \
#     --force
#
#   may need to run a couple of times
#
# AND
#   bin/rails db:migrate
#
# alternatley this spec and associated Page Object Model can be deleted
# with:
#       rm spec/features/blog_crud_spec.rb
#       rm spec/support/pages/blog_page.rb

RSpec.feature "Demonstrate blog CRUD methods", :js do
  let(:blog_page) { Pages::BlogPage.new }

  scenario "A blog is empty and new blog posts can be generated" do
    When "the blog is visited" do
      pending "you generate scaffold Blog to see how this test runs"
      blog_page.load
    end

    Then "there are no blog posts" do
      expect(blog_page.posts).to be_empty
    end

    When "a new post is created" do
      blog_page.new_blog.click
      blog_page.submit!(
        title: "blog title",
        body: "blog body",
        author: "blog author"
      )
    end

    Then "the user is notified the blog was created" do
      expect(blog_page.message).to eq "Blog was successfully created."
    end

    And "the blog has the expected fields" do
      expect(blog_page.blog_title).to have_text "blog title"
      expect(blog_page.body).to have_text "blog body"
      expect(blog_page.author).to have_text "blog author"
    end

    When "the user edits a field" do
      blog_page.edit_blog.click
      blog_page.submit!(
        body: "blog body that has been modified"
      )
    end

    Then "the user is notified the blog was updated" do
      expect(blog_page.message).to eq "Blog was successfully updated."
      expect(blog_page.body).to have_text "blog body that has been modified"
    end

    When "the user views all blogs" do
      blog_page.view_blogs.click
    end

    Then "their 1 blog is displayed" do
      expect(blog_page.posts.length).to eq 1
      expect(blog_page.posts_text).to eq(
        [
          <<~EO_BLOG_CONTENT.chomp
            Title: blog title
            Body: blog body that has been modified
            Author: blog author
          EO_BLOG_CONTENT
        ]
      )
    end

    When "the user views and destroys the blog" do
      blog_page.show_blog!(1)
      blog_page.destroy_blog.click
    end

    Then "the user is notified the blog was updated" do
      expect(blog_page.message).to eq "Blog was successfully destroyed."
    end

    And "there are no blogs" do
      expect(blog_page.posts).to be_empty
    end
  end
end
