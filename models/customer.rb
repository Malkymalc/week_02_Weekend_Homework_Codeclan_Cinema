require_relative('../db/sql_runner')
require_relative('./ticket')
require('pry')

class Customer

  attr_accessor :id
  attr_reader :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
     sql = "INSERT INTO customers (name, funds)
     VALUES ($1, $2)
     RETURNING id"
     values = [@name, @funds]
     customer = SqlRunner.run(sql, values).first
     @id = customer['id'].to_i
   end

   def self.select_all()
     sql = "SELECT * FROM customers"
     customers = SqlRunner.run(sql)
     return customers.map { |customer| Customer.new(customer) }
   end

   def update()
     sql = "UPDATE customers
     SET (name, funds) =
     ($1, $2)
     WHERE id =$3"
     values = [@name, @funds, @id]
     SqlRunner.run(sql, values)
   end

   def delete()
     sql = "DELETE FROM customers WHERE id = $1"
     values = [@id]
     SqlRunner.run(sql, values)
   end

   def self.delete_all()
     sql = "DELETE FROM customers"
     SqlRunner.run(sql)
   end

  def tickets()
    sql = "SELECT * FROM tickets WHERE customer_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets.map { |ticket| Ticket.new(ticket).pretty() }
  end

  def no_of_tickets()
    return tickets().count
  end

  def can_afford?(cost)
    return @funds >= cost
  end

  def pay_money(cost)
    @funds -= cost
    update()
    return cost
  end

  def buy_ticket(screening)
    if screening.seats_left?() && can_afford?(screening.get_cost())
      pay_money(screening.get_cost())
      ticket = Ticket.new({
        'customer_id' => @id,
        'screening_id' => screening.id
        })
      ticket.save()
    end
  end

end
