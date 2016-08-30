require './person'
require './house'
require 'yaml'
# require 'pry'

@palace = House.new

## STDIN
print "Enter name: "
name = gets.strip.split(' ').map(&:capitalize).join(' ')
print "Enter relation: "
relation = gets.strip.downcase


## populates House:family with Person:objects
person = nil
path = './db/members.yml'
yml = YAML::load(File.open(path))
yml['members'].each { |member|
  @palace.family << Person.new(member.last['name'], member.last['gender'], member.last['gen'], member.last['parents'])
  @palace.family.last.addParents(@palace)
  person = @palace.family.last if member.last['name'] == name                   #= identifying Person:object corresponding to the Input:name
}


## Person.findRelatives
relatives = person.findRelatives(relation, @palace)
relatives.empty? ? @palace.defaulter(person, relation) : relatives.each{ |relative| puts relative.name }
