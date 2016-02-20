class Tunnel < ActiveRecord::Base
  validates(
    :name,
    :entrance_id,
    :target_address,
    :destination_port,
    presence: true)

  validates :destination_port, :entrance_id,
    numericality: { only_integer: true }

  validates :target_address,
    :format => { :with => Resolv::IPv4::Regex, :message =>
                 "Not an valid IPv4 format"}
end
