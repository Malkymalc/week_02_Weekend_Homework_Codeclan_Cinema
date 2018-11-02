class Screening

  attr_accessor :id
  attr_reader :time_date, :film_id, :screen_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @time_date = options['time_date']
    @film_id = options['film_id'].to_i
    @screen_id = options['screen_id'].to_i
  end

end
