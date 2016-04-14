class Person
  attr_accessor :name, :gender, :generation, :parents

  def initialize(name, gender, generation, parents)
    self.name = name
    self.gender = gender
    self.generation = generation
    self.parents = parents
  end
end
