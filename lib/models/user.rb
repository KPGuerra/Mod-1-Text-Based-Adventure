class User < ActiveRecord::Base
    has_many :characters
    has_many :enemies, through: :characters
    has_many :items, through: :characters
end 