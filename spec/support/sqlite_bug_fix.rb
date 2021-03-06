# frozen_string_literal: true

# this forces the test sqlite db to use the same connection for all threads
# this is needed otherwise sqlite deadlocks

# rubocop:disable Style/ClassVars
module ActiveRecord
  class Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end
end
# rubocop:enable Style/ClassVars

ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
