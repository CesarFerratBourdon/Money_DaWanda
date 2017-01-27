require 'Money_DaWanda'

RSpec.describe Money_DaWanda::Money do

  before :all do
    Money_DaWanda::Money.conversion_rates('EUR', {'USD' => 1.11, 'Bitcoin' => 0.0047})
  end

    context 'Instantiate an object' do

      specify 'Wrong amount format is passed' do
        forty_euros = Money_DaWanda::Money.new('a', 'EUR')
        expect{forty_euros}.to raise_error(ArgumentError)
      end

      specify 'Wrong currency format is passed' do
        sixty_euros = Money_DaWanda::Money.new(60, 60)
        expect{sixty_euros}.to raise_error(ArgumentError)
      end
    end
    

    context 'Conversion to another currency' do

      let(:fifty_euros){Money_DaWanda::Money.new(50,'EUR')}

      specify 'Exchange EUR to USD' do
        dollar = euro.convert_to('USD')
        expect(dollar.amount).to eq(55.5)
        expect(dollar.currency).to eq('USD')
      end

      specify 'Inspect method' do
        dollar = fifty_euros.convert_to('USD')
        expect(dollar.inspect).to eq '55.50 USD'
      end

      specify 'Wrong currency format is passed to convert_to method' do
        forty_euros = Money_DaWanda::Money.new(40, 'EUR')
        expect{forty_euros.convert_to(USD)).to raise_error(ArgumentError)
      end

      specify 'Exchange to same currency' do
        expect(fifty_euros.convert_to('EUR').amount).to eq(fifty_euros.amount)
        expect(fifty_euros.convert_to('EUR').currency).to eq(fifty_euros.currency)
      end

      specify 'Exchange EUR to USD to EUR' do
        dollar = fifty_euros.convert_to('USD')
        expect(dollar.convert_to('EUR').amount).to eq(fifty_euros.amount)
        expect(dollar.convert_to('EUR').currency).to eq(fifty_euros.currency)
      end

      specify 'Exchange EUR to USD to Bitcoin' do
        dollar = fifty_euros.convert_to('USD')
        expect(dollar.convert_to('Bitcoin').amount).to eq(fifty_euros.convert_to('Bitcoin').amount)
        expect(dollar.convert_to('Bitcoin').currency).to eq(fifty_euros.convert_to('Bitcoin').currency)
      end

    end


    context 'Comparisons between currencies' do

      let(:fifty_euros){Money_DaWanda::Money.new(50,'EUR')}
      let(:twenty_dollars){Money_DaWanda::Money.new(20,'USD')}

      it "is equal if same currency and amount" do
        expect(twenty_dollars).to eq Money_DaWanda::Money.new(20,'USD')
      end

      it "is not equal if same currency but not same amount" do
        expect(twenty_dollars).to_not eq Money_DaWanda::Money.new(30,'USD')
      end

      it "is equal if different currency but same amount after conversion" do
        fifty_euros_in_dollars = fifty_euros.convert_to('USD')
        expect(fifty_euros).to eq fifty_euros_in_dollars
      end

      it "is greater if same currency and greater amount" do
        expect(twenty_dollars).to be > Money_DaWanda::Money.new(5,'USD')
      end

      it "is lower compared to converted amount if different currency" do
        expect(twenty_dollars).to be < fifty_euros
      end
    end


    context 'perform arithmetic operations' do

      let(:fifty_euros){described_class.new(50,'EUR')}
      let(:twenty_dollars){described_class.new(20,'USD')}

      specify 'Addition +' do
        sum = fifty_euros + twenty_dollars
        expect(sum).to eq Money_DaWanda::Money.new(68.02,'EUR')
      end

      specify 'Substraction -' do
        difference = fifty_euros - twenty_dollars
        expect(difference).to eq Money_DaWanda::Money.new(31.98,'EUR')
      end

      specify 'Division /' do
        quotient = fifty_euros / 2
        expect(quotient).to eq Money_DaWanda::Money.new(25.00,'EUR')
      end

      specify 'Multiplication *' do
        product = twenty_dollars * 3
        expect(product).to eq Money_DaWanda::Money.new(60.00,'USD')
      end

    end

end
