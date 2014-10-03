class Project < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :stats, class_name: 'Stats'
  has_many :project_tags
  has_many :tags, through: :project_tags
  belongs_to :user

  paginates_per 20

  # default_scope { select('*, hottness(projects.*) AS hottness') }
  scope :hot,    -> { order(hottness: :desc) }
  scope :top,    -> { order points: :desc }
  scope :recent, -> { order created_at: :desc }
  scope :gems,   -> { where is_gem: true }
  scope :apps,   -> { where is_app: true }

  validates :full_name, presence: true, uniqueness: true, format: { with: /.+\/.+/ }, github_repo: true
  validates :rubygem_name, presence: true, rubygem_gem: true, if: :is_gem

  validates_with ProjectTypeValidator, attributes: [:is_gem, :is_app]

  def calculate_points
    points  = stargazers_count
    points += forks_count
    points += subscribers_count
  end

  def calculate_hottness
    period_stats = stats.where('created_at > ?', DateTime.now - 2.days)

    first_sum   = period_stats.first.stargazers_count
    first_sum  += period_stats.first.subscribers_count
    first_sum  += period_stats.first.forks_count

    last_sum    = period_stats.last.stargazers_count
    last_sum   += period_stats.last.subscribers_count
    last_sum   += period_stats.last.forks_count

    delta = last_sum - first_sum
    self.update_attribute(:hottness, delta)
  end

  def fetch_data
    fetch_github_data
    fetch_rubygem_data
    touch_points
    calculate_hottness
  end

  def touch_points
    self.update_attribute(:points, calculate_points)
  end

  def save_project_stats(opts = {})
    stats_for_today = self.stats.today

    # If there are any stats saved for today,
    # do not create a new ones, just udate the existing ones.
    if stats_for_today.any?
      stats_for_today.last.update_attributes(opts)
    else
      self.stats.create(opts)
    end
  end

  def type
    type = nil
    type = :gem if is_gem
    type = :app if is_app
    type
  end

  private

    def previous_stats
      stats.where('created_at < ?', DateTime.now.beginning_of_day).last
    end

    def fetch_github_data
      desired_params = %w(name description homepage stargazers_count
                          watchers_count forks_count subscribers_count)

      client = Octokit::Client.new \
        client_id:     Rails.application.secrets.github_key,
        client_secret: Rails.application.secrets.github_secret

      repo = client.repository full_name

      params = {}
      desired_params.each do |param|
        params[param.to_sym] = repo.send(param)
      end

      params[:github_id]         = repo.id
      params[:github_created_at] = repo.created_at
      params[:github_pushed_at]  = repo.pushed_at

      save_project_stats(params.slice(:stargazers_count, :subscribers_count, :forks_count))

      self.update_attributes params
    end

    def fetch_rubygem_data
      return false if rubygem_name.blank?

      # Get gem info
      gem = Gems.info rubygem_name

      # Calculate a delta of current downloads_count
      # and downloads_count of previous fetch.
      #
      # If there is no any previous fetch, we need to
      # return 0 to prevent unfair delta rates (for
      # 20134567 total downloads and no previous fetch,
      # the delta would be 20134567, it's just wrong.)
      #
      delta = case previous_stats.present?
        when true

          gem['downloads'] - previous_stats.rubygem_downloads_count
        when false
          0
      end

      params = {
        rubygem_downloads_count: gem['downloads'],
        rubygem_downloads_count_delta: delta
      }
      save_project_stats(params)
    end

end
