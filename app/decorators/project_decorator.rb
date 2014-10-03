class ProjectDecorator < Draper::Decorator
  Inf = 1.0 / 0.0

  delegate_all

  def path
    h.show_projects_path(full_name: object.full_name)
  end

  # Converts datetime to minified version of time_ago_in_words.
  # However, if date is between 1 month and 1 year, it returns
  # datetime in format: 8 Aug. If date is older than 1 year,
  # it returns 8 Aug 2013
  #
  # @param parameter [DateTime]
  # @return [String]
  #
  def mini_time_ago(parameter)
    datetime = object.send(parameter)

    if DateTime.now - 1.month > DateTime.parse(datetime.to_s)
      return datetime.strftime('%-d %b')
    elsif DateTime.now - 1.year > DateTime.parse(datetime.to_s)
      return datetime.strftime('%-d %b %Y')
    end

    datetime_to_taiw_excerpt(datetime)
  end

  # Converts points number to minified version, so
  # 123456 points are converted to 123k
  #
  # @return [String]
  #
  def mini_points
    h.number_to_human(object.points, units: :points, format: '%n%u')
  end

  # Converts project type to capitalized label
  #
  # @return [String]
  #
  def type_label
    object.type.to_s.capitalize
  end

  # Returns a proper bootstrap's color class based on
  # project's hottness score.
  #
  # @todo I don't yet know what point amounts are hot
  #       so we need to adjust it a bit in a future.
  #
  # @return [String]
  #
  def hottness_score_class
    case object.hottness
      when 10..24  then 'text-warning'
      when 25..Inf then 'text-danger'
    end
  end

  private

    # Converts datetime object to shrtened version
    # of time_ago_in_words helper. So 12 days
    # becomes 12d
    #
    # @param datetime [DateTime]
    # @return [String]
    #
    def datetime_to_taiw_excerpt(datetime)
      longer = h.time_ago_in_words(datetime)
      raw    = longer.match(/(\S+ \S+)\z/)[0]
      number = raw.match(/\d+/)[0].to_s
      char   = raw.match(/\s(\S+)/)[0].strip

      number + char.first
    end

end
