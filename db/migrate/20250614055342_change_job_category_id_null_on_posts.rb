class ChangeJobCategoryIdNullOnPosts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :posts, :job_category_id, true
  end
end
