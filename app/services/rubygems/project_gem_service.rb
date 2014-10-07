module Rubygems
  class ProjectGemService

    def initialize(project)
      @project = project
      @client  = set_client
      @gem     = fetch
    end

    def fetch
      @client.info @project.rubygem_name
    end

    def sync
      delta = downloads_delta @gem['downloads']
      params = {
        rubygem_downloads_count: @gem['downloads'],
        rubygem_downloads_count_delta: delta
      }
      @project.save_project_stats(params)
    end

    private

    def set_client
      Gems
    end

    def downloads_delta(downloads)
      case previous_stats.present?
      when true
        downloads - previous_stats.rubygem_downloads_count
      else
        0
      end
    end

    def previous_stats
      @project.stats.where('created_at < ?', DateTime.now.beginning_of_day).last
    end

  end
end