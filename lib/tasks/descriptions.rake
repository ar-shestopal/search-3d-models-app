# lib/tasks/download_descriptions.rake
require 'net/http'
require 'json'

namespace :description do
  desc "Import descriptions from JSON file into database"
  task import: :environment do
    file_path = 'lib/assets/descriptions.json'

    # Read descriptions from the JSON file
    descriptions = JSON.parse(File.read(file_path))

    # Prepare the raw SQL query
    sql = "INSERT INTO prompts (description, created_at, updated_at) VALUES "
    values = descriptions.map do |description|
      timestamp = Time.current.strftime('%Y-%m-%d %H:%M:%S')
      description = ActiveRecord::Base.connection.quote(description)
      "(#{description}, '#{timestamp}', '#{timestamp}')"
    end

    sql += values.join(',')

    # Execute the raw SQL query
    ActiveRecord::Base.connection.execute(sql)

    puts "Import completed. Descriptions added to the database."
  end

  desc "Download descriptions from Hugging Face Datasets Hub"
  task download: :environment do
    base_url = "https://datasets-server.huggingface.co/rows"
    dataset = "Gustavosta%2FStable-Diffusion-Prompts"
    config = "Gustavosta--Stable-Diffusion-Prompts"
    split = "train"
    limit = 100
    offset = 0
    total_records = 100

    descriptions = []

    while offset < total_records
      url = "#{base_url}?dataset=#{dataset}&config=#{config}&split=#{split}&offset=#{offset}&limit=#{limit}"
      response = Net::HTTP.get(URI(url))
      data = JSON.parse(response)

      rows = data["rows"]
      rows.each do |row|
        description = row["row"]["Prompt"]
        descriptions << description
      end

      offset += limit
    end

    # Write descriptions to  file in lib/tasks folder
    file_path = 'lib/assets/descriptions.json'

    File.open(file_path, "w") do |file|
      file.write(JSON.pretty_generate(descriptions))
    end

    puts "Download completed. Descriptions saved to lib/tasks/descriptions.json."
  end
end
