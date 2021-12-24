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
    attr_accessor :POSITIONS




    def initialize
        @board = Array.new(3) { Array.new(3,' ') }
        @POSITIONS = {
            [0,0] => 1,
            [0,1] => 2,
            [0,2] => 3,
            [1,0] => 4,
            [1,1] => 5,
            [1,2] => 6,
            [2,0] => 7,
            [2,1] => 8,
            [2,2] => 9
        }
    end

    def render
        # (0..2).each do |i|
        #     puts " #{i*3 + 1} | #{i*3 + 2} | #{i*3 + 3} "
        #     if i < 2
        #         puts"___________"
        #     end
        # end

        puts " #{@POSITIONS[[0,0]]} | #{@POSITIONS[[0,1]]} | #{@POSITIONS[[0,2]]}"
        puts "____________"
        puts " #{@POSITIONS[[1,0]]} | #{@POSITIONS[[1,1]]} | #{@POSITIONS[[1,2]]}"
        puts "____________"
        puts " #{@POSITIONS[[2,0]]} | #{@POSITIONS[[2,1]]} | #{@POSITIONS[[2,2]]}"

    end

    def place_position(num)
        pos = @POSITIONS.key(num)
        pos
    end



end


class Game

    attr_accessor :board
    attr_reader :current_player

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
        
        puts "It is #{@current_player.name}'s turn.  Please enter a space"
        entry = gets.chomp
        system('clear')
        pos = @board.place_position(entry.to_i)
        if pos == nil || @board.board[pos[0]][pos[1]]!= " " 
            puts "Nice Try.  Please select a free square"
            return false
        end
        @board.board[pos[0]][pos[1]] = @current_player.symbol
        @board.POSITIONS[pos] = @current_player.symbol
        return true
    end

    def switch_player
        if @current_player == @player1
            @current_player = @player2
        else
            @current_player = @player1
        end
    end

    def play

        while !game_draw? && !game_won?
            @board.render
            if get_play
                switch_player
            end

        end

        if game_won?
            switch_player
            puts "#{@current_player.name} is the winner"
            return
        end

        if game_draw?
            puts "no one wins"
            return
        end
    end

end

play = true

while play
    g = Game.new
    g.play
    puts "would you like to play again? (y/n)"
    answer = gets.chomp
    answer == 'n' ? play = false : play = true
end