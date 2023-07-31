# lib/tasks/elasticsearch.rake
namespace :elasticsearch do
  desc 'Import all Prompt records into Elasticsearch'
  task import_prompts: :environment do
    puts "Creating prompts index..."

    Prompt.__elasticsearch__.create_index! force: true

    puts 'Importing prompts...'
    Prompt.import

    puts 'Imported all Prompt records into Elasticsearch'
  end
end
