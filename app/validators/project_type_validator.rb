class ProjectTypeValidator < ActiveModel::EachValidator
  def validate(record)

    values = []
    attributes.each { |a| values << record.send(a) }

    values = values.uniq

    if values == [false]
      record.errors[:base] << (options[:message] || "You need to select a project type")
    end

  end
end