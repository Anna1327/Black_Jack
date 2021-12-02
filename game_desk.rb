require_relative 'card'

class GameDeck
  attr_reader :cards

  def initialize
    @cards = '2,3,4,5,6,7,8,9,10,J,Q,K,A'.split(",").product('♥♠♣♦'.chars).map { |number, suit| Card.new(number, suit) }
  end

  def shuffle!
    @cards.shuffle!
  end

  def card
    @cards.pop
  end
end