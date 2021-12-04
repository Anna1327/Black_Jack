require_relative 'score'
class Hand
  include Score

  def initialize
    @cards = []
  end

  def take(card)
    @cards.push(card) unless @cards.size == 3
  end

  def open
    @cards.map(&:create).join(' ')
  end

  def cards(hide)
    hide ? @cards.map { |_| '*' }.join(' ') : open
  end

  def flush!
    @cards = []
  end

  def full?
    @cards.size == 3
  end
end