class Room < ActiveRecord::Base
  scope :most_recent , order( 'created_at DESC')

  belongs_to :user
  has_many :reviews , :dependent => :destroy

	validates_presence_of :title, :location
	validates_length_of :description, :minimum => 30 , :allow_blank => false

	def complete_name
		"#{title}, #{location}"
	end
end
