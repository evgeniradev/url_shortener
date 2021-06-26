# frozen_string_literal: true

class UrlSerializer < ActiveModel::Serializer
  attributes :id, :url, :short_url, :visits
end
