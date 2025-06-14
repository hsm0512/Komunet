class ChangeStyleIdNullOnPosts < ActiveRecord::Migration[7.1]
  def up
    change_column_null :posts, :style_id, true
  end

  def down
    change_column_null :posts, :style_id, false
  end
end
