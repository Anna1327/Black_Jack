class Card
  attr_reader :number, :suit
  
  def initialize(number, suit)
    @number = number
    @suit = suit
  end
  
  def create
    "#{number}#{suit}"
  end
end