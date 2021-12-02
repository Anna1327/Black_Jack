require_relative 'player'

class Dealer < Player
  def initialize(name = 'Dealer')
    super(name)
    @name = 'Dealer'
  end
end