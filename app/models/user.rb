class User < ActiveRecord::Base
    has_many :characters
    has_many :encounters, through: :characters
    has_many :items, through: :encounters
    has_many :enemies, through: :encounters
end 