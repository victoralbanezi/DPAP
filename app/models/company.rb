class Company < ApplicationRecord
	has_many :fabrics, dependent: :destroy
	
	validates_format_of :cep, :with => /\A^\d{5}[-]?\d{3}$\Z/i
	validates :name, presence: true
	
	belongs_to :owner, class_name: "User", foreign_key: "user_id"


	has_many :company_users
	has_many :users, through: :company_users


	
end
