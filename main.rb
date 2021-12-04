require_relative 'player'
require_relative 'dealer'
require_relative 'card'
require_relative 'hand'
require_relative 'game_desk'
require_relative 'player_actions'

class Main

  PLAYER_ACTIONS = [
    { command: '1', title: 'take card', action: :take },
    { command: '2', title: 'open cards', action: :open },
    { command: '3', title: 'pass', action: :pass }
  ].freeze

  DEALER_ACTIONS = [
    { command: '1', title: 'take card', action: :take },
    { command: '2', title: 'pass', action: :pass }
  ].freeze

  GAME_ACTIONS = [
    { command: '1', title: 'play game' },
    { command: '0', title: 'exit' }
  ].freeze

  BET = 10
  ROUNDS = PLAYER_ACTIONS.size - 1
  STARTING_CARDS_NUMBER = 2
  BLACK_JACK = 21
  GAME_ROUNDS = PLAYER_ACTIONS.size - 1
    
  def initialize
    @player = Player.new(ask_name('Enter your name: '))
    @dealer = Dealer.new('Dealer')
  end

  def show_actions(actions)
    text = "#{@player.name}, your choice:\n"
    actions.each do |action|
      text += " - #{action[:command]} to #{action[:title]}\n"
    end
    puts text
  end

  def start
    puts "Hello, #{@player.name}! Welcome to BLACKJACK game!"
    loop do
      show_actions(GAME_ACTIONS)
      action = gets.chomp.to_i
      break if action.zero?
      play_game
    end
  end

  def ask_name(question)
    print question.to_s
    gets.chomp.downcase
  end

  def play_game
    @round = 1
    @deck = GameDeck.new

    @deck.shuffle!

    @bank = 0
    @bet = BET

    @player.bet(@bet)
    @dealer.bet(@bet)
    @bank += @bet * 2

    @player.hand.flush!
    @dealer.hand.flush!

    STARTING_CARDS_NUMBER.times { @player.hand.take(@deck.card) }
    STARTING_CARDS_NUMBER.times { @dealer.hand.take(@deck.card) }
    continue_game
  end

  def continue_game
    loop do
      break unless @player.can_play?
      break if game_played?

      show_actions(PLAYER_ACTIONS)
      action = player_action
      break if action.zero?

      dealer_action unless PLAYER_ACTIONS[action - 1][:action] == :open
      @round += 1
    end
  end

  def game_played?
    return unless @round == GAME_ROUNDS || @dealer.hand.full?
    end_game
    true
  end

  def wrong_choice(player)
    puts "Wrong choice, #{player.name}"
  end

  def player_action
    action = gets.chomp.to_i

    send PLAYER_ACTIONS[action - 1][:action]
    action
  rescue NoMethodError
    wrong_choice(@player)
    retry
  end

  def dealer_action
    action = gets.chomp.to_i
    send DEALER_ACTIONS[action - 1][:action]
    action
  rescue NoMethodError
    wrong_choice(@dealer)
    retry
  end

  def take
    @player.hand.take(@deck.card)
  end

  def open
    @player.hand.open(@player.hand.cards)
  end

  def pass
    @player.actions.pass
  end

  def end_game
    exit
  end
end

Main.new.start