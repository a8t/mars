include ObjectSpace

class Rover
  attr_reader :x, :y, :direction, :plateau

  def initialize(x,y,direction,plateau)
    @x = x
    @y = y
    @direction = direction
    @plateau = plateau
  end

  def move
    case direction
    when "n"
      puts "Moving north."
      if @plateau.check_for_edge(self)
        puts "Edge detected. Cannot move any further north."
      else
        @y += 1
      end
    when "e"
      puts "Moving east."
      if @plateau.check_for_edge(self)
        puts "Edge detected. Cannot move any further east."
      else
        @x += 1
      end
    when "s"
      puts "Moving south."
      if @plateau.check_for_edge(self)
        puts "Edge detected. Cannot move any further south."
      else
        @y -= 1
      end
    when "w"
      puts "Moving west."
      if @plateau.check_for_edge(self)
        puts "Edge detected. Cannot move any further west."
      else
        @x -= 1
      end
    end
  end

  def turn(l_or_r)
    dir_array = ["n", "e", "s", "w"]
    if l_or_r == "r"
      puts "Turning right!"
      @direction = dir_array[(dir_array.find_index(direction) + 1) % 4]
    else
      puts "Turning left!"
      @direction = dir_array[(dir_array.find_index(direction) - 1) % 4]
    end
  end

  def read_instruction(instruction_string)

    instruction_string.downcase.split("").each do |command|

      if command == "m"
        move
      elsif command == "l"
        turn("l")
      else command == "r"
        turn("r")
      end

    end

    puts "Final coordinates for #{self}: #{x} #{y} #{direction}"
  end

end

class MissionControl

  def send_instruction(instructions_array,targets_array)
    targets_array.each do |rovers|
      rovers.read_instruction(instructions_array[0])

      instructions_array = (instructions_array.length > 1 ?  instructions_array.drop(1) : instructions_array)
    end
  end

end

class Plateau
  attr_reader :xlimit, :ylimit

  def initialize(xlimit,ylimit)
    @xlimit = xlimit
    @ylimit = ylimit
  end

  def report(rover)
    if rover.plateau == self
      "#{rover} coordinates: x = #{rover.x}, y =  #{rover.y}, direction = #{rover.direction}"
    else
      "#{rover} not on this plateau!"
    end
  end

  def report_all
    # show coordinates for ALL rovers which are on this plateau
    ObjectSpace.each_object(Rover) do |rover|
      if rover.plateau == self
        "#{rover} coordinates: x = #{rover.x}, y =  #{rover.y}, direction = #{rover.direction}"
      else
        "#{rover} not on this plateau!"
      end
    end
  end

  def check_for_edge(rover)
    rover.x == xlimit && rover.direction == "e" || rover.y == ylimit && rover.direction == "n" || rover.x == 0 && rover.direction == "w" || rover.y == 0 && rover.direction == "s"
  end

  def check_for_collision

  end




end

landingzone = Plateau.new(9,9)
otherzone = Plateau.new(20,20)

john = Rover.new(1,2,"n",landingzone)
# puts john.read_instruction("LMLMLMLMM")

bob = Rover.new(3,3,"e",landingzone)
# puts bob.read_instruction("MMRMMRMRRM")

control = MissionControl.new
# control.send_instruction(["LMLMLMLMMMMMMMMMM","MMRMMRMRRMMMMMM"],[john,bob])


puts landingzone.report_all
