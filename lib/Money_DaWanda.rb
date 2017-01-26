class Money

  attr_accessor :amount, :currency

  @@conversion_rates = {}

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def inspect
    "#{'%.2f' % amount} + #{currency}"
  end

  def self.add_conversion_rates(currency_base, rates)
    rates.each do |currency,value|
      @@conversion_rates[currency_base][currency] = value
    end
  end


end
