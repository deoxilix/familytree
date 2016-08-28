require './person'

class RoyalHouse
  attr_accessor :royalFamily

  def initialize
    self.royalFamily = []
  end

  ## == These methods identify the "Person" with respective 'relation' with "person" concerned!

  def findMother(person)
   mother = nil
   mother = person.parents.select{ |parent| parent.gender == "F" }.first
   puts mother.name
  end

  def findFather(person)
    father = nil
    father = person.parents.select{ |parent| parent.gender == "M" }.first
    puts father.name
  end

  def findDaughters(person)
    daughters = []
    self.royalFamily.each do |member|
      daughters << member if ( member.gender == "F" && member.parents.include?(person.name) )
    end
      daughters.each { |daughter| puts daughter.name }
  end

  def findSons(person)
    sons = []
    self.royalFamily.each do |member|
      sons << member if ( member.gender == "M" && member.parents.include?(person.name) )
    end
    sons.each { |son| p son.name }
  end

  def findCousins(person)
    cousins = []
    self.royalFamily.each do |member|
      cousins << member if ( member.generation == person.generation && member.parents != person.parents )
    end
    cousins.delete_if { |cousin| cousin.name == person.name }.each { |cousin| p cousin.name }
  end

  def findSiblings(person)
    siblings = []
    self.royalFamily.each do |member|
      siblings << member if ( member.generation = person.generation && member.parents == person.parents )
    end
    siblings.delete_if { |sibling| sibling.name == person.name }.each { |sibling| p sibling.name }
  end

  def findSister(person)
    sisters = []
    self.royalFamily.each do |member|
      sisters << member if ( member.gender == "F" && member.parents === person.parents )
    end
    sisters.delete_if { |sister| sister.name == person.name }.each { |sister| p sister.name }
  end

  def findBrother(person)
    brothers = []
    self.royalFamily.each do |member|
      brothers << member if ( member.gender == "M" && member.parents === person.parents )
    end
    brothers.delete_if { |brother| brother.name == person.name }.each { |brother| p brother.name }
  end

  def findPartner(person)
    if person.parents.length > 1
      self.royalFamily.each do |member|
        partner = member if ( !member.parents.empty? && member.parents.all? { |x| x == person.name } )
      end
    else
      partner = self.royalFamily[self.royalFamily.index { |member| member.name == person.parents.first }]
    end
    p partner.name unless partner.nil?
  end
end


# def defaulter(person, relation)
#   puts "#{name} doesnot have a #{relation}"
# end
