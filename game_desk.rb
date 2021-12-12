require_relative 'card'

class GameDeck
  attr_reader :cards

  def initialize
    @cards = '23456789TJQKA'.chars.product('♥♠♣♦'.chars).map { |value, suit| Card.new(value, suit) }
  end

  def shuffle!
    @cards.shuffle!
  end

  def card
    @cards.pop
  end
end