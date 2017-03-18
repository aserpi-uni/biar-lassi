class Consumer < ApplicationRecord
  devise :database_authenticatable,
         :confirmable,
         # :omniauthable
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
end
