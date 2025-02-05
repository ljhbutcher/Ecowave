class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :materials, dependent: :destroy
  has_many :summaries
  has_many :questions
end
