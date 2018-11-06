require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/screen')
require_relative('../models/screening')
require_relative('../models/ticket')

require('pry')

Customer.delete_all()
Film.delete_all()
Screen.delete_all()

customer1 = Customer.new({
  'name' => 'alan',
  'funds' => 1
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'bob',
  'funds' => 2
  })
customer2.save()

customer3 = Customer.new({
  'name' => 'chris',
  'funds' => 3
  })
customer3.save()

film1 = Film.new({
  'title' => 'Predator',
  'cost' => 1,
  'rating' => 18
  })
film1.save()

film2 = Film.new({
  'title' => 'Alien',
  'cost' => 2,
  'rating' => 18
  })
film2.save()

film3 = Film.new({
  'title' => 'Commando',
  'cost' => 3,
  'rating' => 18
  })
film3.save()

screen1 = Screen.new({
  'name' => 'Big Screen',
  'capacity' => 5
  })
screen1.save()

screen2 = Screen.new({
  'name' => 'Small Screen',
  'capacity' => 1
  })
screen2.save()

screening1 = Screening.new({
  'time_date' => '14:00',
  'film_id' => film1.id,
  'screen_id' => screen1.id
  })
screening1.save()

screening2 = Screening.new({
  'time_date' => '14:00',
  'film_id' => film2.id,
  'screen_id' => screen1.id
  })
screening2.save()

screening3 = Screening.new({
  'time_date' => '18:00',
  'film_id' => film1.id,
  'screen_id' => screen1.id
  })
screening3.save()

#CUSTOMER TESTS
  customer3.buy_ticket(screening1)
  customer3.buy_ticket(screening2)

  customer1.buy_ticket(screening1)
  customer1.buy_ticket(screening2)


# FILM TESTS

# film1.screenings()
# film1.tickets_sold()
# film1.most_pop_screening()
binding.pry
nil
