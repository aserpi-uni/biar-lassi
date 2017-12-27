require 'test_helper'

class ProblemThreadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @problem_thread = problem_threads(:one)
  end

  test "should get index" do
    get problem_threads_url
    assert_response :success
  end

  test "should get new" do
    get new_problem_thread_url
    assert_response :success
  end

  test "should create problem_thread" do
    assert_difference('ProblemThread.count') do
      post problem_threads_url, params: { problem_thread: { content: @problem_thread.content, title: @problem_thread.title } }
    end

    assert_redirected_to problem_thread_url(ProblemThread.last)
  end

  test "should show problem_thread" do
    get problem_thread_url(@problem_thread)
    assert_response :success
  end

  test "should get edit" do
    get edit_problem_thread_url(@problem_thread)
    assert_response :success
  end

  test "should update problem_thread" do
    patch problem_thread_url(@problem_thread), params: { problem_thread: { content: @problem_thread.content, title: @problem_thread.title } }
    assert_redirected_to problem_thread_url(@problem_thread)
  end

  test "should destroy problem_thread" do
    assert_difference('ProblemThread.count', -1) do
      delete problem_thread_url(@problem_thread)
    end

    assert_redirected_to problem_threads_url
  end
end
