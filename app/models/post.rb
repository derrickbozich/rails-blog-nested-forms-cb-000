class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, :through => :post_tags

  # accepts_nested_attributes_for :tags, reject_if: proc { |attributes| attributes['name'].blank? }

  validates_presence_of :name, :content

  def tags_attributes=(tags_hashes)
    tags_hashes.each do |tag_attributes|
      tag = Tag.create_or_find_by(:name => tag_attributes[:name])
    end
  end
end
