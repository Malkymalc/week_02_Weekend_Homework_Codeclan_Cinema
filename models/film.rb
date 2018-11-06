require_relative('../db/sql_runner')

class Film

  attr_accessor :id
  attr_reader :title, :cost, :rating

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @cost= options['cost'].to_i
    @rating = options['rating'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, cost, rating)
    VALUES ($1, $2, $3)
    RETURNING id"
    values = [@title, @cost, @rating]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.select_all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film) }
  end

  def update()
    sql = "UPDATE films
    SET (title, cost, rating) =
    ($1, $2, $3)
    WHERE id =$4
    "
    values = [@title, @cost, @rating, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def screenings()
    sql = "SELECT * FROM screenings
          WHERE screenings.film_id = $1"
    values = [@id]
    screenings =  SqlRunner.run(sql, values)
    return screenings.map { |screening| Screening.new(screening).info() }
  end


  def tickets_sold()
    sql = "SELECT tickets.* FROM tickets
          INNER JOIN screenings
          ON tickets.screening_id = screenings.id
          INNER JOIN films
          ON screenings.film_id = films.id
          WHERE films.id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).count
  end

  def most_pop_screening()
    sql = "SELECT * FROM screenings
          WHERE screenings.film_id = $1"
    values = [@id]
    screenings_sql =  SqlRunner.run(sql, values)
    screenings = screenings_sql.map { |screening| Screening.new(screening) }
    return screenings.sort_by { |screening| screeing.tickets_sold() }
  end

end
