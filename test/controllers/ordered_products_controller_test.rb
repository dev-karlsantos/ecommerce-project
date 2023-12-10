require "test_helper"

class OrderedProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ordered_products_index_url
    assert_response :success
  end

  test "should get show" do
    get ordered_products_show_url
    assert_response :success
  end
end
