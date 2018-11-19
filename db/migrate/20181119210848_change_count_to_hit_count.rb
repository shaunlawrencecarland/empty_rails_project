class ChangeCountToHitCount < ActiveRecord::Migration[5.2]
  def change
    rename_column :urls,  :count, :hit_count
  end
end
