require 'test_helper'

module OperationResultCache
  class << self
    attr_accessor :result
  end
end

class DummyFailOperation < Trailblazer::Operation
  step -> (*) {}
end

class DummySuccessOperation < Trailblazer::Operation
  step -> (*) { true }
end

class EnsureParamsOperation < Trailblazer::Operation
  step -> (*, params:, **options) {
    OperationResultCache.result = { params: params, options: options }
  }
end

class Trailblazer::ActiveJob::BaseTest < Minitest::Test
  def test_raise_on_operation_failure
    exception =
      assert_raises do
        Trailblazer::ActiveJob::Base.perform_now(operation: 'DummyFailOperation', options: {})
      end
    assert_kind_of RuntimeError, exception
    assert_match /\ATrailblazer::ActiveJob::Base \(Job ID: \S+\) failed while running operation DummyFailOperation with options {}\.\z/, exception.message
  end

  def test_succeed_on_operation_success
    # do not raise if operation succeeded
    Trailblazer::ActiveJob::Base.perform_later(operation: 'DummySuccessOperation', options: {})
  end

  def test_succeed_async_on_operation_success
    params = { params1: 'value1', 'param2' => 'value2' }
    perform_enqueued_jobs do
      Trailblazer::ActiveJob::Base.perform_later(operation: 'EnsureParamsOperation', options: { params: params })
    end
    assert_equal({ params: params, options: {} }, OperationResultCache.result)
  end
end
