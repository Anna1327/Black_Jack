module Table
  def table_game
    puts "#{'*' * 20} Bank $#{@bank} #{'*' * 20}"
    puts "#{@player.name}: cards: #{@player.hand.cards(false)}, score: #{@player.hand.card_score}, bank: $#{@player.bank}"
    puts "#{@dealer.name}: cards: #{@dealer.hand.cards(true)}, bank: $#{@dealer.bank}"
    puts '-' * 50
  end
  
  def table_open
    puts "#{'*' * 20} Bank $#{@bank} #{'*' * 20}"
    puts "#{@player.name}: cards: #{@player.hand.open}, score: #{@player.hand.card_score}, bank: $#{@player.bank}"
    puts "#{@dealer.name}: cards: #{@dealer.hand.open}, score: #{@dealer.hand.card_score}, bank: $#{@dealer.bank}"
    puts 'Game countinue' unless winner
    puts "#{winner.name} wins!" if winner
    puts '-' * 50
  end
  
  def wrong_choice
    puts "Wrong choice, #{@player.name}"
  end
end