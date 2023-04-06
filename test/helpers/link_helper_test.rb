require 'test_helper'

class LinkHelperTest < ActionView::TestCase
  test "#new_link" do
    # you can use @view.helpers
    assert_equal "/new/", new_link
  end
end
