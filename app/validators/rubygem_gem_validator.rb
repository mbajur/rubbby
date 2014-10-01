class RubygemGemValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    # Do not run this validator if there are any
    # other errors for provided field already there
    return true if record.errors[attribute].any?

    begin
      rubygem_gem = search_gem(value)

    rescue Rubbby::Exceptions::Rubygems::NotFound => e
      record.errors[attribute] << (options[:message] || "does not exists")

    end

  end

  private

    def search_gem(name)
      info = Gems.info name

      fail Rubbby::Exceptions::Rubygems::NotFound \
        if info == 'This rubygem could not be found.'
    end
end