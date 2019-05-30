# frozen_string_literal: true

if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        alias per per_page
      end
    end
  end
end
