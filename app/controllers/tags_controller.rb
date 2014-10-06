class TagsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  def index
    @tags = Tag.all.page(params[:page])
    @tags_count = Tag.count(:id)
    apply_scope_filters
  end

  # GET /tags/1
  def show
    @project = @project.decorate
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.friendly.find(params[:id])
    end

    def apply_scope_filters
      @tags = case params[:scope]
        when 'top'    then @tags.top
        when 'recent' then @tags.recent
        else @tags.hot
      end
    end
end
