require_relative('../db/sql_runner')
require('pry')

class Ticket

  attr_accessor :id
  attr_reader :customer_id, :screening_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, screening_id)
    VALUES ($1, $2)
    RETURNING id"
    values = [@customer_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.select_all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql, values)
    return tickets.map { |ticket| Ticket.new(ticket) }
  end

  def update()
    sql = "UPDATE tickets
    SET (customer_id, screening_id) =
    ($1, $2)
    WHERE id =$3
    "
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def get_screening()
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [@screening_id]
    return SqlRunner.run(sql, values)[0]
  end

  def get_film_title()
    return get_screening.get_film_title()
  end

  def get_screen_name()
    return get_screening.get_screen_name()
  end

  def get_time_date()
    return get_screening.time_date
  end

  def info()
  title = get_film_title()
  time = time_date
  screen = get_screen_name()
  info =  {
      "Title" => title,
      "Time" => time,
      "Screen" => screen
    }
    return info
  end


end
