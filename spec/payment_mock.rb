class PaymentMock
  attr_accessor :price, :alfa_order_id, :alfa_form_url, :paid, :description
  attr_accessor :user_id, :id, :card_number, :binding_id

  def initialize(price: 100, description: 'Огурцы, салат и лук', user_id: 1)
    @id = 1
    @price = price
    @description = description
    @user_id = user_id
  end

  def update_attribute(attr, val)
    instance_variable_set("@#{attr}", val)
  end

  def update_attributes(alfa_order_id:, alfa_form_url:)
    @alfa_order_id = alfa_order_id
    @alfa_form_url = alfa_form_url
  end

  def save(validate:)
  end
end

