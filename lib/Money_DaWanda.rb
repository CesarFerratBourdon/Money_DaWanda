class Money

  attr_accessor :amount, :currency

  @@conversion_rates = {}

  def initialize(amount, currency)
    raise ArgumentError, 'Amount is not numeric' unless amount.is_a? Numeric
    raise ArgumentError, 'Currency should be a string' unless currency.is_a? String

    @amount = amount
    @currency = currency
  end

  def inspect
    "#{'%.2f' % amount} + #{currency}"
  end

  def self.add_conversion_rates(currency_base, rates)
    raise ArgumentError, 'Currency should be a string' unless currency_base.is_a? String
    raise ArgumentError, 'Rates should be a hash' unless rates.is_a? Hash

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
    raise ArgumentError, 'Currency should be a string' unless new_currency.is_a? String
    # check if conversion rate exists inside @@conversion_rate table
    if @@conversion_rates.has_key?[@currency] && @@conversion_rate[@currency].has_key?[new_currency]
      rate = @@conversion_rates[@currency][new_currency]
    #if not, but reversed rate exists, use it
    elsif @@conversion_rates.has_key?[new_currency] && @@conversion_rate[new_currency].has_key?[@currency]
      rate = 1 / @@conversion_rates[new_currency][@currency]
    else
      return "This currency exchange is unfortunately not available"
    end

    new_amount = (@amount * rate).round(2)
    return Money.new(new_amount,new_currency)
  end

#Arithmetics
  def +(money)
    if money.currency != @currency && money.amount != 0
      return Money.new(@amount + (money.convert_to(@currency)).amount, @currency)
    elsif money.amount != 0  #if money.amount == 0 we don't even bother creating a new Money instance
      return Money.new(@amount + money.amount, @currency)
    end
  end

  def -(money)
    if money.currency != @currency && money.amount != 0
      return Money.new(@amount - (money.convert_to(@currency)).amount, @currency)
    elsif money.amount != 0  #if money.amount == 0 we don't even bother creating a new Money instance
      return Money.new(@amount - money.amount, @currency)
    end
  end

  def *(number)
    raise ArgumentError, 'Number should be a non nil numeric'  unless number.is_a?(Numeric) and number != 0
      return Money.new((@amount * number).round(2), @currency)
  end

  def /(number)
    raise ArgumentError, 'Number should be a non nil numeric'  unless number.is_a?(Numeric) and number != 0
      return Money.new((@amount / number).round(2), @currency)
  end

#Comparisons
  def ==(money)
    if money.currency != @currency && money.amount != 0
      money = (money.convert_to(@currency))
    end
      return @amount == money.amount
  end

  def >(money)
    if money.currency != @currency && money.amount != 0
      money = (money.convert_to(@currency))
    end
      return @amount > money.amount
  end

  def <(money)
    if money.currency != @currency && money.amount != 0
      money = (money.convert_to(@currency))
    end
      return @amount < money.amount
  end





end
