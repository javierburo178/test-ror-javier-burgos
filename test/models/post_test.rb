require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:default)
  end

  test 'should validate length of title' do
    assert_must validate_length_of(:title), @post
  end

  test 'should validate presence of title' do
    assert_must validate_presence_of(:title), @post
  end

  test 'should validate presence of description' do
    assert_must validate_presence_of(:description), @post
  end
end
