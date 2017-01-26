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

  def self.show_conversion_rates
    @@conversion_rates.each do |currency_base,rates|
      puts currency_base + ' => ' + rates +'/n----------/n'
    end
  end


end
