class ProjectCell < Cell::Rails

  def list_show(opts)
    @project = opts[:project].decorate
    @tags    = @project.tags.decorate

    render
  end

end
