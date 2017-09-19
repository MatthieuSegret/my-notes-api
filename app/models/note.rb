class Note < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 10 }
  cattr_accessor(:paginates_per) { 3 }

  def self.paginate(offset)
    offset ||= 0
    offset(offset).limit(self.paginates_per)
  end
end
