class Player
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Board

    def initialize
        @board = Array.new(3) { Array.new(3) }
    end
end

class Game

    def initialize

        puts "Enter player 1 Name"
        name = gets.chomp
        @player1 = Player.new(name,'X')

        puts "Enter player 2 Name"
        name = gets.chomp
        @player2 = Player.new(name,'O')
    end

end