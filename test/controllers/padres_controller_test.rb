require 'test_helper'

class PadresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get padres_index_url
    assert_response :success
  end

end
