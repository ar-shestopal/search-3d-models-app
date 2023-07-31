# app/controllers/prompts_controller.rb
class PromptsController < ApplicationController
  def index
    if params[:q].present?
      @prompts = SearchService.perform(params[:q]).page(params[:page])
    else
      @prompts = Prompt.order(created_at: :desc).page(params[:page])
    end
  end

  def search
    @prompts = SearchService.perform(params[:q])

    if @prompts.empty?
      flash.now[:notice] = 'No prompts match your search.'
    end

    render :index
  end
end
