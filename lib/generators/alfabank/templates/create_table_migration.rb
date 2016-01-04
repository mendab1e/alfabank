class Create<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    create_table :<%= table_name %> do |t|
      t.integer :price, null: false
      t.string :alfa_order_id
      t.string :alfa_form_url
      t.boolean :payed
      t.boolean :use_binding

      t.timestamps null: false
    end

    add_index :<%= table_name %>, :alfa_order_id
  end
end
