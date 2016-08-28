require './person'
require './royal_house'
require 'pry'
require 'yaml'

@palace = RoyalHouse.new

## populates @palace.royalFamily with Person:objects

path = './db/members.yml'
yml = YAML::load(File.open(path))
yml['members'].each { |member|
  @palace.royalFamily << Person.new(member.last['name'], member.last['gender'], member.last['gen'], member.last['parents'])
  @palace.royalFamily.last.objectifyParents(@palace)
}

print "Enter name: "
name = gets.strip.capitalize
print "Enter relation: "
relation = gets.strip.downcase

person = nil
@palace.royalFamily.each do |member|
  person = member if member.name == name                                        #= identifying Person:object corresponding to the input :name
end

## @palace.findRelatives

@palace.findSiblings(person) if "siblings".include?(relation)
@palace.findBrother(person) if "brothers".include?(relation)
@palace.findSister(person) if "sisters".include?(relation)
@palace.findCousins(person) if "cousins".include?(relation)
@palace.findSons(person) if "sons".include?(relation)
@palace.findDaughters(person) if "daughters".include?(relation)
@palace.findMother(person) if "mothermomparents".include?(relation)
@palace.findFather(person) if "fatherdadparents".include?(relation)
@palace.findPartner(person) if "wifehusbandpartnermarriedto".include?(relation)
