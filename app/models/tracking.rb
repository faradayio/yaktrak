class Tracking < ActiveRecord::Base
  set_primary_key :package_identifier
  attr_accessible :package_identifier
end
