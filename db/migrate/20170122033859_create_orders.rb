class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :receipent
      t.string :tel
      t.string :address
      t.string :company_id, limit: 10
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
