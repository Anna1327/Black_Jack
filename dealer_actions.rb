module DealerActions
  DEALER_POINTS_FOR_WIN = 17

  def dealer_take
    @dealer.hand.take(@game_deck.card) if @dealer.hand.card_score < DEALER_POINTS_FOR_WIN
  end

  def dealer_pass?
    @dealer.hand.card_score >= DEALER_POINTS_FOR_WIN
  end

  def dealer_action
    dealer_take unless dealer_pass?
  end
end