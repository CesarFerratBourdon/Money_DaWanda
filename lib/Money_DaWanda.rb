class Money

  attr_accessor :amount, :currency

  @@conversion_rates = {}

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end


end
