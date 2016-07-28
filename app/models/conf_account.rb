class ConfAccount < ActiveRecord::Base

  belongs_to :user

  def self.create_account(product_id,user_id)
    product = Product.find_by(id: product_id)
    if product.present?
      account = self.new
      account.product_id = product.id
      account.user_id = user_id
      account.credits = product.price
      account.total_sessions = product.total_sessions
      account.storage = product.storage
      account.total_usage = product.total_usage
      account.total_persons = product.total_persons
      account.save
    end
  end

end