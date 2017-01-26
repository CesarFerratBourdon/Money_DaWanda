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

  def convert_to(new_currency)
    # check if conversion rate exists inside @@conversion_rate table
    if @@conversion_rates.has_key?[@currency] && @@conversion_rate[@currency].has_key?[new_currency]
      rate = @@conversion_rates[@currency][new_currency]
    #if not, but reversed rate exists, use it
    elsif @@conversion_rates.has_key?[new_currency] && @@conversion_rate[new_currency].has_key?[@currency]
      rate = 1 / @@conversion_rates[new_currency][@currency]
    else
      return "This currency exchange is unfortunately not available"
    end

    new_amount = @amount * rate
    return Money.new(new_amount,new_currency)
  end


end
