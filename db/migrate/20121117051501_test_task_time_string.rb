class TestTaskTimeString < ActiveRecord::Migration
  def change
  	change_column :tasks, :time, :string
  end
end
