class Enemy < ActiveRecord::Base
    has_many :battles
    has_many :characters, through: :battles
    has_many :users, through: :battles
end 