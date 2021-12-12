require_relative 'player'
require_relative 'dealer'
require_relative 'card'
require_relative 'hand'
require_relative 'game_desk'
require_relative 'player_actions'
require_relative 'dealer_actions'
require_relative 'table'

class Main
  include PlayerActions
  include DealerActions
  include Table

  PLAYER_ACTIONS = [
    { command: '1', title: 'take card', action: :take },
    { command: '2', title: 'open cards', action: :open },
    { command: '3', title: 'pass', action: :pass }
  ].freeze

  BET = 10
  ROUNDS = PLAYER_ACTIONS.size - 1
  STARTING_CARDS_NUMBER = 2
  BLACK_JACK = 21
  GAME_ROUNDS = PLAYER_ACTIONS.size - 1

  GAME_ACTIONS = [
    { command: '1', title: 'play game' },
    { command: '0', title: 'exit' }
  ].freeze
    
  def initialize
    @player = Player.new(ask_name('Enter your name: '))
    @dealer = Dealer.new('Dealer')
  end

  def start
    puts "Hello, #{@player.name}! Welcome to BlackJack game!"
    loop do
      show_actions(GAME_ACTIONS)
      action = gets.chomp.to_i
      break if action.zero?
      if action == 1
        play_game
        continue_game
      else
        wrong_choice(@player)
      end
    end
  end

  protected

  def show_actions(actions)
    text = "#{@player.name}, your choice:\n"
    actions.each do |action|
      text += " - #{action[:command]} to #{action[:title]}\n"
    end
    puts text + '-' * 50
  end

  def play_game
    @round = 1
    @game_deck = GameDeck.new
    @game_deck.shuffle!
    @bank = 0
    @bet = BET

    @player.bet(@bet)
    @dealer.bet(@bet)
    @bank += @bet * 2

    @player.hand.flush!
    @dealer.hand.flush!
    STARTING_CARDS_NUMBER.times { @player.hand.take(@game_deck.card) }
    STARTING_CARDS_NUMBER.times { @dealer.hand.take(@game_deck.card) }
  end

  def ask_name(question)
    print question.to_s
    gets.chomp.downcase
  end

  def continue_game
    loop do
      break unless @player.can_play?

      break if game_played?

      table_game
      show_actions(PLAYER_ACTIONS)
      action = player_action
      break if action.zero?

      dealer_action unless PLAYER_ACTIONS[action - 1][:action] == :open
      @round += 1
    end
  end

  def player_action
    action = gets.chomp.to_i

    send PLAYER_ACTIONS[action - 1][:action]
    action
  rescue NoMethodError
    wrong_choice(@player)
    retry
  end

  def wrong_choice(player)
    puts "Wrong choice, #{player.name}"
  end

  def winner
    return @dealer if @player.hand.card_score > BLACK_JACK
    return @player if @dealer.hand.card_score > BLACK_JACK
    return @dealer if BLACK_JACK - @dealer.hand.card_score < BLACK_JACK - @player.hand.card_score
    return @player if BLACK_JACK - @dealer.hand.card_score > BLACK_JACK - @player.hand.card_score

    nil if @dealer.hand.card_score == @player.hand.card_score
  end

  def game_played?
    return unless @round == GAME_ROUNDS || @dealer.hand.full?

    end_game
    table_open
    true
  end

  def end_game
    return draw if draw?

    winner.win(@bank)
  end

  def draw?
    winner.nil?
  end

  def draw
    @player.win(@bet)
    @dealer.win(@bet)
  end
end

Main.new.start