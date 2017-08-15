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
      elsif @plateau.check_for_collision(self)
        puts "Collision imminent. Cannot move any further north."
      else
        @y += 1
      end
    when "e"
      puts "Moving east."
      if @plateau.check_for_edge(self)
        puts "Edge detected. Cannot move any further east."
      elsif @plateau.check_for_collision(self)
        puts "Collision imminent. Cannot move any further east."
      else
        @x += 1
      end
    when "s"
      puts "Moving south."
      if @plateau.check_for_edge(self)
        puts "Edge detected. Cannot move any further south."
      elsif @plateau.check_for_collision(self)
        puts "Collision imminent. Cannot move any further south."
      else
        @y -= 1
      end
    when "w"
      puts "Moving west."
      if @plateau.check_for_edge(self)
        puts "Edge detected. Cannot move any further west."
      elsif @plateau.check_for_collision(self)
        puts "Collision imminent. Cannot move any further west."
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
      puts "#{x},#{y},#{direction}"
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
    rover_hash = {}

    ObjectSpace.each_object(Rover) do |rover|
      if rover.plateau == self
        rover_hash[:"#{rover}"] = [rover.x, rover.y, rover.direction]
      end
    end

    return rover_hash
  end

  def check_for_edge(rover)
    rover.x == xlimit && rover.direction == "e" || rover.y == ylimit && rover.direction == "n" || rover.x == 0 && rover.direction == "w" || rover.y == 0 && rover.direction == "s"
  end

  def check_for_collision(self_rover)

    # removes self from comparison
    allbutself = report_all.delete_if { |remove_rover, remove_coords| "#{remove_rover}" == "#{self_rover}"}

    i = 0

    if self_rover.direction == "n"
      while i < allbutself.values.transpose[0].size
        if self_rover.x == allbutself.values.transpose[0][i] && self_rover.y == allbutself.values.transpose[1][i] - 1
          return true
        else i+= 1
        end
      end
    elsif self_rover.direction == "e"
      while i < allbutself.values.transpose[0].size
        if self_rover.y == allbutself.values.transpose[1][i] && self_rover.x == allbutself.values.transpose[0][i] - 1
          return true
        else i+= 1
        end
      end
    elsif self_rover.direction == "s"
      while i < allbutself.values.transpose[0].size
        if self_rover.x == allbutself.values.transpose[0][i] && self_rover.y == allbutself.values.transpose[1][i] + 1
          return true
        else i+= 1
        end
      end
    elsif self_rover.direction == "w"
      while i < allbutself.values.transpose[0].size
        if self_rover.y == allbutself.values.transpose[1][i] && self_rover.x == allbutself.values.transpose[0][i] + 1
          return true
        else i+= 1
        end
      end
      false
    end


    # this works but only tests one other rover at a time
    # allbutself.each do |compare_rover, compare_coords|
    #
    #
    #   return self_rover.direction == "n" && self_rover.y == (compare_coords[1] - 1)  && self_rover.x == compare_coords[0] || self_rover.direction == "e" && self_rover.x == compare_coords[0] - 1 && self_rover.y == compare_coords[1] || self_rover.direction == "s" && self_rover.y == compare_coords[1] + 1 && self_rover.x == compare_coords[0] || self_rover.direction == "w" && self_rover.x == compare_coords[0] + 1 && self_rover.y == compare_coords[1]
    #
    # end

  end




end

landingzone = Plateau.new(9,9)
otherzone = Plateau.new(20,20)

john = Rover.new(1,2,"n",landingzone)
# puts john.read_instruction("LMLMLMLMM")

bob = Rover.new(1,5,"e",landingzone)
# puts bob.read_instruction("MMRMMRMRRM")

lucy = Rover.new(2,4,"e",landingzone)

other = Rover.new(3,3,"e",otherzone)

control = MissionControl.new
# control.send_instruction(["LMLMLMLMMMMMMMMMM","MMRMMRMRRMMMMMM"],[john,bob])


john.read_instruction("MRMMMMLMM")
