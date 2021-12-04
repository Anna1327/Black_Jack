require_relative 'score'
require_relative 'player'
require_relative 'card'

class PlayerActions
  include Score

  def initialize(player)
    @player = player
    @cards = player.cards
  end

  def take(card)
    @cards.push(card) unless @cards.size == 3
  end

  def pass
    # do nothing 
  end

  def open
    @cards.map { |_| '*' }.join(' ')
  end
end