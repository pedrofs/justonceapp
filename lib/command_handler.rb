class CommandHandler
  def with_aggregate(aggregate_class, aggregate_id, &block)
    aggregate = aggregate_class.new(aggregate_id)
    stream = stream_name(aggregate_class, aggregate_id)
    repository.with_aggregate(aggregate, stream, &block)
  end

  def rehydrate(aggregate, stream)
    repository.load(aggregate, stream)
  end

  def stream_name(aggregate_class, aggregate_id)
    "#{aggregate_class.name}$#{aggregate_id}"
  end

  protected

  def repository
    @repository ||= AggregateRoot::Repository.new(Rails.configuration.event_store)
  end
end
