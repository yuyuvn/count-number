require 'test_helper'

class ClicksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get clicks_create_url
    assert_response :success
  end

end
