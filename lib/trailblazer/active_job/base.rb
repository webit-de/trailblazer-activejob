class Trailblazer::ActiveJob::Base < ::ActiveJob::Base
  def perform(operation:, options:)
    option_output = options.inspect
    operation_class = operation.constantize
    result =
      if Gem.loaded_specs['trailblazer'].version < Gem::Version.new('2.1.0.rc1')
        # TRB 2.0
        params = options.delete('params') || options.delete(:params) || {}
        operation_class.(params, options)
      else
        # TRB 2.1
        operation_class.(options)
      end
    if result.failure?
      raise "#{self.class.name} (Job ID: #{self.job_id}) failed while running operation #{operation} with options #{option_output}."
    end
  end
end
