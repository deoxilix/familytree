class House
  attr_accessor :family

  def initialize
    self.family = []
  end


  ## These methods identify the :Person in respective 'relation' with :Person concerned!
  def findMother(person)
   mother = []
   mother << person.parents.select{ |parent| parent.gender == "F" }.first
   mother
  end

  def findFather(person)
    father = []
    father << person.parents.select{ |parent| parent.gender == "M" }.first
    father
  end

  def findChildren(person)
    children = []
    self.family.each do |member|
      children << member if ( member.parents.length > 1 && member.parents.include?(person) )
    end
    children
  end

  def findDaughters(person)
    daughters = []
    self.family.each do |member|
      daughters << member if ( member.parents.length > 1 && member.gender == "F" && member.parents.include?(person) )
    end
    daughters
  end

  def findSons(person)
    sons = []
    self.family.each do |member|
      sons << member if ( member.parents.length > 1 && member.gender == "M" && member.parents.include?(person) )
    end
    sons
  end

  def findSisters(person)
    sisters = []
    return sisters if person.nil?
    self.family.each do |member|
      sisters << member if ( member.gender == "F" && member.parents === person.parents && member != person )
    end
    sisters
  end

  def findBrothers(person)
    brothers = []
    return brothers if person.nil?
    self.family.each do |member|
      brothers << member if ( member.gender == "M" && member.parents === person.parents && member != person )
    end
    brothers
  end

  def findCousins(person)
    cousins = []
    self.family.each do |member|
      cousins << member if ( member.parents.length > 1 && member.generation == person.generation && member.parents != person.parents )
    end
    cousins.delete_if { |cousin| cousin.name == person.name }
  end

  def findPartner(person)
    partner = []
    if person.parents.length > 1
      self.family.each do |member|
        partner << member if ( !member.parents.empty? && member.parents.all? { |x| x == person } )
      end
    else
      partner << person.parents.first
    end
    partner
  end

  def findBrothersInLaw(person)
    if person.parents.length == 1
      findBrothers(person.parents.first)
    else
      return []
    end
  end

  def findSistersInLaw(person)
    if person.parents.length == 1
      findSisters(person.parents.first)
    else
      return []
    end
  end

  def findUncle(person)
    findBrothers(person.parents.find{ |parent| parent.parents.length > 1 })
  end

  def findAunt(person)
    findSisters(person.parents.find{ |parent| parent.parents.length > 1 })
  end

  def findGrandDaughters(person)
    grandDaughters = []
    findChildren(person).each{ |child| grandDaughters << findDaughters(child) }
    grandDaughters.flatten
  end

  def defaulter(person, relation)
    puts "#{person.name} doesnot have a #{relation}!"
  end
end
