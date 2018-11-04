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
  'capacity' => 2
  })
screen1.save()

screen2 = Screen.new({
  'name' => 'Small Screen',
  'capacity' => 1
  })
screen2.save()
