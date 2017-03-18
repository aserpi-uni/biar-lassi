class Admin < ApplicationRecord
  devise :database_authenticatable,
         :confirmable,
         :lockable,
         :recoverable,
         :rememberable,
         :registerable,
         :timeoutable,
         :trackable,
         :validatable
end
