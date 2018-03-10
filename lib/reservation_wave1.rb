require 'date'
module Hotel
  class Reservation
    attr_reader :start_date,:end_date,:room_number
    def initialize(start_date,end_date,room_number)
      if start_date >= end_date
        raise ArgumentError.new("Check-in date must be before check-out date")
      elsif start_date < Date.today
        raise ArgumentError.new("check_in date cannot be before today's date")
      end
      @start_date = start_date
      @end_date = end_date
      @room_number = room_number


    end

  end
end
