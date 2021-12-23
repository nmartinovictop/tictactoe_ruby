class Player
    attr_reader :name
    attr_reader :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Board

    attr_accessor :board

    def initialize
        @board = Array.new(3) { Array.new(3,' ') }
    end

    def render
        (0..2).each do |i|
            puts " #{@board[i][0]} | #{@board[i][1]} | #{@board[i][2]} "
            if i < 2
                puts"___________"
            end
        end
    end


end


class Game

    attr_accessor :board

    def initialize

        puts "Enter player 1 Name"
        name = gets.chomp
        @player1 = Player.new(name,'X')

        puts "Enter player 2 Name"
        name = gets.chomp
        @player2 = Player.new(name,'O')
        @board = Board.new

        @current_player = @player1
    end

    def game_won?

        if @board.board[0].all?('X') || @board.board[0].all?('O')
            return true
        elsif  @board.board[1].all?('X') || @board.board[1].all?('O')
            return true
        elsif  @board.board[2].all?('X') || @board.board[2].all?('O')
            return true
        elsif @board.board.transpose[0].all?('X') || @board.board.transpose[0].all?('O')
            return true
        elsif @board.board.transpose[1].all?('X') || @board.board.transpose[1].all?('O')
            return true
        elsif @board.board.transpose[2].all?('X') || @board.board.transpose[2].all?('O')
            return true
        elsif [@board.board[0][0],@board.board[1][1],@board.board[2][2]].all?('X') || [@board.board[0][0],@board.board[1][1],@board.board[2][2]].all?('O')
            return true
        elsif [@board.board[0][2],@board.board[1][1],@board.board[2][0]].all?('X') || [@board.board[0][2],@board.board[1][1],@board.board[2][0]].all?('O')
            return true
        else
            return false
        end
    end

    def game_draw?
        if @board.board.flatten.none?(" ")
            return true
        end
        false
    end

    def get_play
        puts "It is #{@current_player.name}'s turn.  Please enter a space like '0,1'"
        entry = gets.chomp.split(",")
        @board.board[entry[0].to_i][entry[1].to_i] = @current_player.symbol
    end

    def play

        while !game_draw? && !game_won?
            @board.render
            get_play
            if @current_player == @player1
                @current_player = @player2
            else
                @current_player = @player1
            end

        end

        puts "done"
    end

end

g = Game.new
g.play