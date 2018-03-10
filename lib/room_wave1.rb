#require_relative 'spec_helper.rb'
module Hotel

  class Room
    attr_reader :number
    def initialize(number)
      @number = number
      if @number < 1 || @number > 20
        raise ArgumentError.new("Invalid room number")
      end
    end


  end
end
