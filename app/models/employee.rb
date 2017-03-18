class Employee < ApplicationRecord
  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :rememberable,
         :registerable,
         :trackable,
         :validatable
end
