require_relative('../db/SqlRunner')

class Screen

  attr_accessor :id
  attr_reader :name, :capacity

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['title']
    @capacity = options['cost'].to_i
  end

  def save()
    sql = "INSERT INTO screens (name, capacity)
    VALUES ($1, $2)
    RETURNING id"
    values = [@name, @capacity]
    screen = SqlRunner.run(sql, values).first
    @id = screen['id'].to_i
  end

  def self.select_all()
    sql = "SELECT * FROM screens"
    screens = SqlRunner.run(sql, values)
    return screens.map { |screen| Screen.new(screen) }
  end

  def update()
    sql = "UPDATE screens
    SET (name, capacity) =
    ($1, $2)
    WHERE id =$3
    "
    values = [@name, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screens WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screens"
    SqlRunner.run(sql)
  end

  def screenings()
    sql = "SELECT * FROM screenings
          WHERE screenings.film_id = $1"
    values = [@id]
    screenings_sql =  SqlRunner.run(sql, values)
    return screenings.map { |screening| Screening.new(screening).pretty() }
  end

end
