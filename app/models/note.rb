class Note < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 10 }
  cattr_accessor(:paginates_per) { 3 }

  has_many :comments

  def self.paginate(offset)
    offset ||= 0
    offset(offset).limit(self.paginates_per)
  end

  def self.search(keywords)
    return self if keywords.blank?
    where('lower(title) like :keywords OR lower(content) like :keywords', keywords: "%#{keywords.downcase}%")
  end
end
