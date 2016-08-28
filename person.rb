# require "RoyalHouse"

class Person
  attr_accessor :name, :gender, :generation, :parents, :children

  def initialize(name, gender, generation, parents)
    self.name = name
    self.gender = gender
    self.generation = generation
    self.parents = parents
  end

  def objectifyParents(familyObj)
    self.parents.map do |parent|
      familyObj.royalFamily.each do |member|
        member if member.name == parent
      end
    end
  end
end
