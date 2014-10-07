module Github
  class ProjectRepoService

    DESIRED_PARAMS = %w(
      name description homepage
    )

    attr_reader :project
    attr_reader :repo

    def initialize(project)
      @project = project
      @client  = set_client
      @repo    = fetch
    end

    # Saves repository data and repo stats data for
    # given project
    #
    def sync
      @project.save_project_stats build_stats_params
      @project.update_attributes  build_project_params
    end

    private

    # Initializes GitHub client
    #
    # @return [Object] Octokit client
    #
    def set_client
      Octokit::Client.new \
        client_id:     Rails.application.secrets.github_key,
        client_secret: Rails.application.secrets.github_secret
    end

    # Fetches github repository
    #
    # @return [Hash]
    #
    def fetch
      @client.repository @project.full_name
    end

    # Builds hash of project params used when
    # updating existing project with the data obtained
    # from github api
    #
    # @return [Hash]
    #
    def build_project_params
      params = {}
      DESIRED_PARAMS.each do |param|
        params[param.to_sym] = @repo.send(param.to_sym)
      end

      params[:github_id]         = @repo.id
      params[:github_created_at] = @repo.created_at
      params[:github_pushed_at]  = @repo.pushed_at
      params
    end

    # Builds hash of stats params
    #
    # @return [Hash]
    #
    def build_stats_params
      {
        stargazers_count:  @repo[:stargazers_count],
        subscribers_count: @repo[:subscribers_count],
        forks_count:       @repo[:forks_count],
      }
    end

  end
end