require 'rails_helper'

RSpec.describe Project, :type => :model do
  before do
    stub_request(:get, /.*api.github.com.*/).to_return(status: 200)
    stub_request(:get, /.*rubygems.org.*/)
      .to_return(status: 200, body: {name: 'something'}.to_json)

    @project = FactoryGirl.build(:project)
  end

  it 'has a valid factory' do
    expect(@project).to be_valid
  end

  it 'is invalid without a full_name provided' do
    @project.full_name = nil
    expect(@project).to_not be_valid
  end

  it 'is invalid without is_gem or is_rails set to true' do
    @project.is_gem = false
    @project.is_app = false
    expect(@project).to_not be_valid
  end

  it 'is invalid with wrong formatted full_name' do
    @project.full_name = 'rails'
    expect(@project).to_not be_valid
  end

  it 'is invalid with non existing github repo full_name' do
    stub_request(:get, /.*api.github.com.*/).to_return(status: 404)

    @project.full_name = 'rails/wrong_repo_name'
    expect(@project).to_not be_valid
  end

  context 'when is_gem is set to true' do
    before do
      @project.is_gem = true
    end

    it 'is invalid without rubygem_name set' do
      @project.rubygem_name = nil
      expect(@project).to_not be_valid
    end

    it 'is invalid with non existing rubygem gem' do
      stub_request(:get, /.*rubygems.org.*/)
        .to_return(status: 404, body: "This rubygem could not be found.")

      @project.rubygem_name = 'non_existing_gem'
      expect(@project).to_not be_valid
    end
  end
end