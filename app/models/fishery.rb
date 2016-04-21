class Fishery < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates_presence_of :name, message: "Fishery name can't be blank"

  has_many :waters, dependent: :destroy

  has_one  :contact_details
  accepts_nested_attributes_for :contact_details

  has_one  :address
  accepts_nested_attributes_for :address

  def latitude
    return google_places_details["geometry"]["location"]["lat"] if google_places_details?
    address.latitude
  end

  def longitude
    return google_places_details["geometry"]["location"]["lng"] if google_places_details?
    address.longitude
  end

  private

  def google_places_details
    return nil if place_id.blank?
    Geocoder.search(place_id, :lookup => :google_places_details).first.data
  end

  def google_places_details?
    !place_id.blank?
  end

end
