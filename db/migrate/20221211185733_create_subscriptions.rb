class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :person
      t.references :course
      t.integer :status, default: 1
      t.decimal :amount
      t.decimal :paid_amount
      t.decimal :payment_date
      t.integer :form_of_payment

      t.timestamps
    end
  end
end
