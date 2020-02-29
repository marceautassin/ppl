class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :documents
  has_many :doc_lines, through: :documents
  has_one_attached :photo
  validates :first_name, :last_name, :social_security_number, presence: true

  validates :social_security_number, format: { with: /\d{15}/,
  message: "15 numbers!" }
  #etre plus precis pour la rubular peut etre pas mal
end
