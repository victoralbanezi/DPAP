require 'csv'

class Fabric < ApplicationRecord
  belongs_to :company
  has_many :fabric_to_carts, dependent: :destroy
  
  has_many :label_to_fabrics, dependent: :destroy
  has_many :labels, through: :label_to_fabrics
  
  has_many_attached :photos, dependent: :destroy

  has_many :fabric_to_orders, dependent: :nullify
  has_many :orders, through: :fabric_to_orders

  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  include PgSearch::Model
  pg_search_scope :search_by_name_colour_width_gramatura_composition_and_fabric_type,
    against: [ :name, :colour, :width, :gramatura, :composition, :fabric_type ],
    using: {
      tsearch: { prefix: true } 
    }

  def self.read_colors
    filepath    = 'app/assets/colors_in_pt.csv'
    colors = []
    CSV.foreach(filepath) do |row|
      colors << row[0]
    end

    colors
  end

  COLORS = self.read_colors

end
