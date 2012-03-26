class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.timestamp :timestamp
    end
  end

  def down
  end
end
