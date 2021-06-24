# frozen_string_literal: true

class Url < ApplicationRecord
  belongs_to :user

  VALID_REGEX = URI::DEFAULT_PARSER.make_regexp(%w[http https])

  validates :url, presence: true
  validates :url, uniqueness: { scope: :user }
  validates :url, format: { with: VALID_REGEX, message: 'requires a valid protocol' }
  validates :url, length: { maximum: 2048 }
  validates :user, presence: true
  validates :slug, uniqueness: true, presence: true

  scope :for_user, ->(user) { where(user: user) }

  def short_url
    Rails.application.routes.url_helpers.url_url(slug)
  end

  def concurrent_increment!
    Thread.new do
      ActiveRecord::Base
        .connection
        .execute("UPDATE urls SET visits = visits + 1 WHERE id = #{id};")
    end
  end
end
