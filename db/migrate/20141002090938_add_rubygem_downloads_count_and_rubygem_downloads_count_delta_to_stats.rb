class AddRubygemDownloadsCountAndRubygemDownloadsCountDeltaToStats < ActiveRecord::Migration
  def change
    add_column :stats, :rubygem_downloads_count, :integer, default: 0
    add_column :stats, :rubygem_downloads_count_delta, :integer, default: 0
  end
end
