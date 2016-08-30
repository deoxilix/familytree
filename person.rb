class Person
  attr_accessor :name, :gender, :generation, :parents

  def initialize(name, gender, generation, parents)
    self.name = name
    self.gender = gender
    self.generation = generation
    self.parents = parents
  end

  ## Populates parents' array with corresponding Person:objects.
  def addParents(palace)
    self.parents.map! do |parent|
      palace.family.find{ |member| member.name == parent }
    end
  end

  def findRelatives(relation, palace)
    relatives = nil
    case
    when "fatherdadparents".include?(relation)
      relatives = palace.findFather(self)

    when "mothermomparents".include?(relation)
      relatives = palace.findMother(self)

    when "children".include?(relation)
      relatives = palace.findChildren(self)

    when "sons".include?(relation)
      relatives = palace.findSons(self)

    when "daughters".include?(relation)
      relatives = palace.findDaughters(self)

    when "brothers".include?(relation)
      relatives = palace.findBrothers(self)

    when "sisters".include?(relation)
      relatives = palace.findSisters(self)

    when "cousins".include?(relation)
      relatives = palace.findCousins(self)

    when "wifehusbandpartnerspouse".include?(relation)
      relatives = palace.findPartner(self)

    when "brotherinlaw".include?(relation.gsub(/\W+/, ""))
      relatives = palace.findBrothersInLaw(self)

    when "sisterinlaw".include?(relation.gsub(/\W+/, ""))
      relatives = palace.findSistersInLaw(self)

    when "paternal uncle".include?(relation), "maternal uncle".include?(relation)
      relatives = palace.findUncle(self)

    when "paternal aunt".include?(relation), "maternal aunt".include?(relation)
      relatives = palace.findAunt(self)

    when "grand daughter".include?(relation)
      relatives = palace.findGrandDaughters(self)
      
    else
      relatives = []
    end
    relatives
  end

end
