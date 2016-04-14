require './person'
require './royal_house'
require 'pry'
require 'yaml'
# %w{./person ./royal_house pry yaml }.each { |x| require x }

@palace = RoyalHouse.new

## Adds a member to the :royalFamily[]
path = './members.yml'
yml = YAML::load(File.open(path))
yml['members'].each{ |member|
  # binding.pry
  @palace.royalFamily << Person.new(member.last['name'], member.last['gender'], member.last['gen'], member.last['parents'])
  # binding.pry
}

print "Enter name: "
name = gets.strip.capitalize
print "Enter relation: "
relation = gets.strip.downcase

person = nil
@palace.royalFamily.each do |member|
  person = member if member.name == name
end

def findMother(person)
  mother = nil
  @palace.royalFamily.each do |member|
    mother = member if person.parents.include?(member.name) && member.gender == "F"
  end
  p mother.name
end

def findFather(person)
  father = nil
  @palace.royalFamily.each do |member|
    father = member if person.parents.include?(member.name) && member.gender == "M"
  end
  p father.name
end

def findDaughters(person)
  daughters = []
  @palace.royalFamily.each do |member|
    daughters << member if ( member.gender == "F" && member.parents.include?(person.name) )
  end
    daughters.each { |daughter| p daughter.name }
end

def findSons(person)
  sons = []
  @palace.royalFamily.each do |member|
    sons << member if ( member.gender == "M" && member.parents.include?(person.name) )
  end
  sons.each { |son| p son.name }
end

def findCousins(person)
  cousins = []
  @palace.royalFamily.each do |member|
    cousins << member if ( member.generation == person.generation && member.parents != person.parents )
  end
  cousins.delete_if { |cousin| cousin.name == person.name }.each { |cousin| p cousin.name }
end

def findSiblings(person)
  siblings = []
  @palace.royalFamily.each do |member|
    siblings << member if ( member.generation = person.generation && member.parents == person.parents )
    # binding.pry
  end
  siblings.delete_if { |sibling| sibling.name == person.name }.each { |sibling| p sibling.name }
end

def findSister(person)
  sisters = []
  @palace.royalFamily.each do |member|
    sisters << member if ( member.gender == "F" && member.parents === person.parents )
    # binding.pry
  end
  sisters.delete_if { |sister| sister.name == person.name }.each { |sister| p sister.name }
end

def findBrother(person)
  brothers = []
  @palace.royalFamily.each do |member|
    brothers << member if ( member.gender == "M" && member.parents === person.parents )
  end
  brothers.delete_if { |brother| brother.name == person.name }.each { |brother| p brother.name }
end

def findPartner(person)
  if person.parents.length > 1
    @palace.royalFamily.each do |member|
      # binding.pry
      partner = member if ( !member.parents.empty? && member.parents.all? { |x| x == person.name } )
    end
  else
    partner = @palace.royalFamily[@palace.royalFamily.index { |member| member.name == person.parents.first }]
  end
  # binding.pry
  p partner.name unless partner == nil
end

# def defaulter(person, relation)
#   puts "#{name} have a #{relation}"
# end

findSiblings(person) if "siblings".include?(relation)
findBrother(person) if "brothers".include?(relation)
findSister(person) if "sisters".include?(relation)
findCousins(person) if "cousins".include?(relation)
findSons(person) if "sons".include?(relation)
findDaughters(person) if "daughters".include?(relation)
findMother(person) if "mothermomparents".include?(relation)
findFather(person) if "fatherdadparents".include?(relation)
findPartner(person) if "wifehusbandpartnermarriedto".include?(relation)
