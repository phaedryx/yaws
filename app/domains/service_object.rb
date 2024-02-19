class ServiceObject
  # use dry-transaction instead of Actionable
  include ::Dry::Transaction

  # use the same class-level interface as Callable
  def self.call(...)
    step(:step, with: :step) if steps.empty?

    new.call(...)
  end
end
