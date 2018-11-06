require_relative('../db/sql_runner')

class Screening

  attr_accessor :id
  attr_reader :time_date, :film_id, :screen_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @time_date = options['time_date']
    @film_id = options['film_id'].to_i
    @screen_id = options['screen_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (time_date, film_id, screen_id)
    VALUES ($1, $2, $3)
    RETURNING id"
    values = [@time_date, @film_id, @screen_id]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def self.select_all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql, values)
    return screenings.map { |screening| Screening.new(screening).pretty() }
  end

  def update()
    sql = "UPDATE screenings
    SET (time_date, film_id, screen_id) =
    ($1, $2, $3)
    WHERE id =$4
    "
    values = [@time_date, @film_id, @screen_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def get_cost()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    return SqlRunner.run(sql, values)[0]['cost'].to_i
  end

  def tickets_sold()
    sql = "SELECT * FROM tickets WHERE screening_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).count
  end

  def seats()
    sql = "SELECT * FROM screens WHERE id = $1"
    values = [@screen_id]
    return  SqlRunner.run(sql, values)[0]['capacity'].to_i
  end

  def seats_left?()
    return tickets_sold() < seats()
  end

  def get_film_title()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    return SqlRunner.run(sql, values)[0]['title']
  end

  def get_screen_name()
    sql = "SELECT * FROM screens WHERE id = $1"
    values = [@screen_id]
    return SqlRunner.run(sql, values)[0]['name']
  end

  def info()
  info =  {
      "Title" => get_film_title(),
      "Time" => time_date,
      "Screen" => get_screen_name(),
      "Tickets Sold" => "#{tickets_sold()}/#{seats()}"
    }
    return info
  end

end
