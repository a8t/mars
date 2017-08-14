class Rover
  attr_reader :x, :y, :direction

  def initialize(x,y,direction)
    @x = x
    @y = y
    @direction = direction
  end

  def move
    case direction
    when "n"
      puts "Moving north!"
      @y += 1
    when "e"
      puts "Moving east!"
      @x += 1
    when "s"
      puts "Moving south!"
      @y -= 1
    when "w"
      puts "Moving west!"
      @x -= 1
    end
  end

  def turn(l_or_r)
    dir_array = ["n", "e", "s", "w"]
    if l_or_r == "r"
      puts "Turning right!"
      @direction = dir_array[(dir_array.find_index(direction) + 1)%4]
    else
      puts "Turning left!"
      @direction = dir_array[(dir_array.find_index(direction) - 1)]
    end
  end

  def read_instruction(instruction_string)

    instruction_string.downcase.split("").each do |command|

      if command == "m"
        move
        puts "#{x} #{y} #{@direction}"
        puts
      elsif command == "l"
        turn("l")
        puts "#{x} #{y} #{@direction}"
        puts
      else command == "r"
        turn("r")
        puts "#{x} #{y} #{@direction}"
        puts
      end

    end

    "#{x} #{y} #{direction}"
  end

end

bob = Rover.new(3,3,"e")
# puts bob.direction
# bob.turn("l")
# puts bob.direction
# bob.turn("r")
# puts bob.direction
# bob.turn("l")
# bob.move
#
# puts "#{bob.x} #{bob.y} #{bob.direction}"
#
# puts
#
# bob.turn("l")
# bob.move
# bob.turn("l")
# bob.move
# bob.turn("l")
# bob.move
# bob.turn("l")
# bob.move
# bob.move
#
# puts


puts bob.read_instruction("MMRMMRMRRM")
