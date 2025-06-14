class ChangeJobCategoryIdNullOnPostsForce < ActiveRecord::Migration[7.1]
  def up
    change_column_null :posts, :job_category_id, true
  end

  def down
    change_column_null :posts, :job_category_id, false
  end
end
