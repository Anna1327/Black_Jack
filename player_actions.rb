require_relative 'score'
require_relative 'player'
require_relative 'card'

module PlayerActions
  def initialize(player)
    @player = player
    @cards = player.cards
  end

  private

  def take
    @player.hand.take(@game_deck.card)
  end

  def pass
    # do nothing
  end

  def open
    @player.hand.open
  end
end