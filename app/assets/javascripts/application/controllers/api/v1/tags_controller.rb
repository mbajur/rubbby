class Api::V1::TagsController < Api::V1Controller
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @tags = Tag.accepted
  end

end