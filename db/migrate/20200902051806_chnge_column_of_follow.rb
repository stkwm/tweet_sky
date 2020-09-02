class ChngeColumnOfFollow < ActiveRecord::Migration[5.0]
  def change
    add_column :follows, :followed_id, :integer
    remove_column :follows, :post_id, :integer
  end
end
