class TagDecorator < Draper::Decorator
  delegate_all

  def to_s
    object.name
  end

  def path
    h.tag_path(object.slug)
  end

end
