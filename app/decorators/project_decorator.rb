class ProjectDecorator < Draper::Decorator
  delegate_all

  def path
    h.show_projects_path(full_name: object.full_name)
  end

  def mini_time_ago(parameter)
    datetime = object.send(parameter)

    if DateTime.now - 1.month > DateTime.parse(datetime.to_s)
      return datetime.strftime('%-d %b')
    elsif DateTime.now - 1.year > DateTime.parse(datetime.to_s)
      return datetime.strftime('%-d %b %Y')
    end

    longer = h.time_ago_in_words(datetime)
    raw    = longer.match(/(\S+ \S+)\z/)[0]
    number = raw.match(/\d+/)[0].to_s
    char   = raw.match(/\s(\S+)/)[0].strip

    number + char.first
  end

  def mini_points
    h.number_to_human(object.points, units: :points, format: '%n%u')
  end

  def type_label
    object.type.to_s.capitalize
  end

end
