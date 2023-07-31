# app/services/search_service.rb
class SearchService
  def self.perform(query)
    return [] unless query.present?

    Prompt.where('description ILIKE ?', "%#{query}%").order(created_at: :desc)
  end
end
