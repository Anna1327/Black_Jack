require_relative 'hand'
class Player
  attr_reader :name, :bank, :hand

  def initialize(name, bank = 100)
    @name = name.capitalize!
    @bank = bank
    @hand = Hand.new
  end

  def bet(bet)
    @bank -= bet
  end

  def win(bank)
    @bank += bank
  end

  def can_play?
    puts "You've lost all(" unless bank.positive?
    bank.positive?
  end
end