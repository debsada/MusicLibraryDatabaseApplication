class Person
    def initialize (name, birthday, language)
        @name = name
        @birthday = birthday 
        @language = language
    end

    def name
        return @name
    end
end 

person1 = Person.new("Deborah", "1 April", "Python")

puts person1
puts person1.name