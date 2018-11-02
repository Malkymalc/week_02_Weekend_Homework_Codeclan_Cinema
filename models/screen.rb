class Screen

  attr_accessor :id
  attr_reader :name, :capacity

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['title']
    @capacity = options['cost'].to_i

  end

end
