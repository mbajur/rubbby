class ScopeSidebarCell < Cell::Rails

  helper_method :current_class_for
  helper_method :controller_path

  def show(opts = {})
    @root_path = opts[:root_path]
    render
  end

  private

    def current_class_for(scope)
      if scope.to_s == params[:scope]
        return 'active'
      elsif scope == :hot && !params[:scope].present?
        return 'active'
      end
    end

    def controller_path(params = {})
      @root_path + '?' + params.to_query
    end

end
