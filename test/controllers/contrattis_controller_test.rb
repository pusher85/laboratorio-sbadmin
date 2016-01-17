require 'test_helper'

class ContrattisControllerTest < ActionController::TestCase
  setup do
    @contratti = contrattis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contrattis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contratti" do
    assert_difference('Contratti.count') do
      post :create, contratti: { acquisto: @contratti.acquisto, clienti_id: @contratti.clienti_id, note: @contratti.note, ore: @contratti.ore }
    end

    assert_redirected_to contratti_path(assigns(:contratti))
  end

  test "should show contratti" do
    get :show, id: @contratti
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contratti
    assert_response :success
  end

  test "should update contratti" do
    patch :update, id: @contratti, contratti: { acquisto: @contratti.acquisto, clienti_id: @contratti.clienti_id, note: @contratti.note, ore: @contratti.ore }
    assert_redirected_to contratti_path(assigns(:contratti))
  end

  test "should destroy contratti" do
    assert_difference('Contratti.count', -1) do
      delete :destroy, id: @contratti
    end

    assert_redirected_to contrattis_path
  end
end
