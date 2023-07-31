# app/models/prompt.rb
require 'elasticsearch/model'

class Prompt < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  self.per_page = 10

  # Define the Elasticsearch index settings and mappings here.
  # For example:
  settings index: { number_of_shards: 1, number_of_replicas: 0 } do
    mappings dynamic: 'false' do
      indexes :description, type: 'text'
    end
  end
end

