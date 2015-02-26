class Listing < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "200x200", :thumb => "100x100>" }, :default_url => "omg.jpg"
	else
		has_attached_file :image, :styles => { :medium => "200x200", :thumb => "100x100>" }, :default_url => "omg.jpg",
						  :storage => :dropbox,
						  :path => ":style/:id_:filename",
	   					  :dropbox_credentials => Rails.root.join("config/dropbox.yml")
	   					  #:dropbox_options => {...}
	end
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates_attachment_presence :image

  belongs_to :user
  has_many :orders
end
