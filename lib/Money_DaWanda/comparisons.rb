module Money_DaWanda
  module Comparisons

    [:<, :>, :==].each do |comparator|
      define_method(comparator) do |money|
          if money.currency != @currency && money.amount != 0
            money = (money.convert_to(@currency))
          end
        return @amount.send(comparator, money.amount)
      end
    end
    
  end
end
