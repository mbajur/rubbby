namespace :rubbby do
  desc "Fetch data of all repositories"
  task fetch_all: :environment do
    Project.all.each.with_index do |p, index|
      print "#{index}. Fetching #{p.name} ... "
      p.fetch_github_data
      puts 'done'
    end
  end

end
