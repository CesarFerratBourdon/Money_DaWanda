module Money_DaWanda
  module Arithmetics

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
    
  end
end
