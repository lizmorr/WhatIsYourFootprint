class UseReason < ActiveRecord::Base
  has_many :usages

  validates :name, presence: true
end
