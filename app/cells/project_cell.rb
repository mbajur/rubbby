class ProjectCell < Cell::Rails

  def list_show(opts)
    @project = opts[:project].decorate

    render
  end

end
