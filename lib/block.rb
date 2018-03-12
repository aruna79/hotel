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


  end
end
