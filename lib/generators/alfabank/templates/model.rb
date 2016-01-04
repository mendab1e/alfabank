class <%= class_name %> < ActiveRecord::Base
  include Alfabank

  validates_numericality_of :price, greater_than: 0
end
