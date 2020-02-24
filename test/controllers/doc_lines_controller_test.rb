require 'test_helper'

class DocLinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get doc_lines_index_url
    assert_response :success
  end

end
