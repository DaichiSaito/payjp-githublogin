class CreatePayjpCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :payjp_customers do |t|
      t.string :customer_id, null: false
      t.references :user, null: false, foreign_key: true
      t.string :last4, null: false
      t.string :exp_year, null: false
      t.string :exp_month, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
