# frozen_string_literal: true

module SerializerHelpers
  def each_serializer(collection:, serializer:)
    json =
      ActiveModel::Serializer::CollectionSerializer
      .new(collection, each_serializer: serializer)
      .to_json

    JSON.parse(json)
  end
end

RSpec.configure do |config|
  config.include SerializerHelpers, type: :controller
end
