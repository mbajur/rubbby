class GithubRepoValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    return true if record.errors[attribute].any?
    return true unless record.send("#{attribute}_changed?")

    user  = record.user

    # We're using user token here to reduce github
    # rate limiting a bit
    gh = Octokit::Client.new(token: user.services.last.token)

    begin
      gh.repository(value)

    rescue Octokit::NotFound
      record.errors[attribute] << (options[:message] || "does not exists")

    end

  end
end