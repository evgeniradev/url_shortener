# frozen_string_literal: true

class SlugGeneratorService
  class << self
    def call
      SecureRandom.alphanumeric(11)
    end
  end
end
