module Hotel
  class BlockReservation
    attr_reader :start_date,:end_date,:room_number, :discount_rate, :block_id, :status
    def initialize(start_date,end_date,room_number,discount_rate,block_id, status=true)
      @start_date = start_date
      @end_date = end_date
      @room_number = room_number
      @discount_rate = discount_rate
      @block_id = block_id
      @status = status
    end
    def create_block(start_date, end_date, block_id, discount_rate)
      if start_date.class != Date || end_date.class!=Date
        raise ArgumentError.new("Invalid date")
      end
      avail_rooms = get_available_rooms(start_date,end_date)

      (0..4).each do |i|
        room_block = avail_rooms[i]
        #  print room_block
        reservation_block = Hotel::BlockReservation.new(start_date,end_date,room_block, discount_rate, block_id)
        @block_reservation << reservation_block
      end
      return @block_reservation

    end
    def check_block_availability(block_id)
      block_records = @block_reservation.select{|block| block.block_id == block_id && block.status == true}
      if block_records.empty?
        raise Exception.new("No rooms are available in the block")
      else
        return block_records
      end
    end


  end
end
