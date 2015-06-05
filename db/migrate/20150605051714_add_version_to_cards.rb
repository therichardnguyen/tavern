class AddVersionToCards < ActiveRecord::Migration
  def change
    add_column :cards, :version, :string
  end
end
