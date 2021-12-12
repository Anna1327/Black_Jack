module Score
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def card_score
      ace = @cards.select { |card| card.number == 'A' }
      others = @cards.select { |card| card.number.match(/[\dJQK]/) }
      sum = others.reduce(0) { |s, card| s + card.number.to_i }
      ace.reduce(sum) do |s, _|
        s + 11 > 21 ? s + 1 : s + 11
      end
    end
  end
end