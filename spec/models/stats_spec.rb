require 'rails_helper'

RSpec.describe Stats, :type => :model do
  before do
    stub_request(:get, /.*api.github.com.*/).to_return(status: 200)
    stub_request(:get, /.*rubygems.org.*/)
      .to_return(status: 200, body: {name: 'something'}.to_json)

    @stats = FactoryGirl.build(:stats)
  end

  it 'has a valid factory' do
    expect(@stats).to be_valid
  end

  describe '#calculate_points' do
    it 'returns a sum of stargazers, subscribers and forks' do
      @stats.stargazers_count = 100
      @stats.subscribers_count = 200
      @stats.forks_count = 300

      expect(@stats.calculate_points).to eq 600
    end
  end

  describe '#self.gain_for_month' do
    it 'returns gain for given attribute and month' do
      project = FactoryGirl.create(:project)
      datetime = DateTime.now

      stats_beginning = {
        created_at: datetime.beginning_of_month - 1.month,
        stargazers_count: 100,
        project: project
      }
      stats_end = {
        created_at: datetime.end_of_month - 1.month,
        stargazers_count: 1389,
        project: project
      }
      FactoryGirl.create(:stats, stats_beginning)
      FactoryGirl.create(:stats, stats_end)

      expect(project.stats.gain_for_month(:stargazers_count, datetime - 1.month)).to eq 1289
    end
  end

  describe '#self.percentage_gain_this_month' do
    def project_with_month_stats(first, second, third, fourth)
      project = FactoryGirl.create(:project)

      # Previous month
      stats_beginning_prev_month = {
        created_at: DateTime.now.beginning_of_month - 1.month,
        stargazers_count: first,
        project: project
      }
      stats_end_prev_month = {
        created_at: DateTime.now.end_of_month - 1.month,
        stargazers_count: second,
        project: project
      }

      # Current month
      stats_beginning_this_month = {
        created_at: DateTime.now.beginning_of_month,
        stargazers_count: third,
        project: project
      }
      stats_end_this_month = {
        created_at: DateTime.now.beginning_of_month + 10.days,
        stargazers_count: fourth,
        project: project
      }

      FactoryGirl.create(:stats, stats_beginning_prev_month)
      FactoryGirl.create(:stats, stats_end_prev_month)
      FactoryGirl.create(:stats, stats_beginning_this_month)
      FactoryGirl.create(:stats, stats_end_this_month)

      project
    end

    context 'when gain is positive' do
      subject do
        p = project_with_month_stats(100, 200, 300, 800)
        p.stats.percentage_gain_this_month(:stargazers_count)
      end

      it { should eq 500 }
    end

    context 'when gain is negative' do
      subject do
        p = project_with_month_stats(100, 500, 600, 700)
        p.stats.percentage_gain_this_month(:stargazers_count)
      end

      it { should eq -25 }
    end

    context 'when gain is the same' do
      subject do
        p = project_with_month_stats(100, 500, 600, 1000)
        p.stats.percentage_gain_this_month(:stargazers_count)
      end

      it { should eq 100 }
    end

    context 'when there is no gain' do
      subject do
        p = project_with_month_stats(100, 500, 500, 500)
        p.stats.percentage_gain_this_month(:stargazers_count)
      end

      it { should eq 0 }
    end

    context 'when there was no gain in previous month' do
      subject do
        p = project_with_month_stats(100, 100, 200, 300)
        p.stats.percentage_gain_this_month(:stargazers_count)
      end

      it { should eq 100 }
    end
  end

end