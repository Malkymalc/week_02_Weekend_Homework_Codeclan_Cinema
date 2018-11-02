class Film

  attr_accessor :id
  attr_reader :time_date, :film_id, :screen_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @cost= options['cost'].to_i
    @rating = options['rating'].to_i
  end

end
