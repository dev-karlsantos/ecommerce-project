class Province < ApplicationRecord
  has_many :users

  validates :province_name, uniqueness: true, presence: true
end
