class Movie < ApplicationRecord
  has_many :actors, dependent: :destroy
end
