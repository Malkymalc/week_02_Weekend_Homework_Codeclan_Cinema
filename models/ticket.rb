class Tickets

  attr_accessor :id
  attr_reader :customer_id, :screening_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

end
