class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, :through => :post_tags

  # accepts_nested_attributes_for :tags, reject_if: proc { |attributes| attributes['name'].blank? }

  validates_presence_of :name, :content

  def tags_attributes=(tags_hashes)
    tags_hashes.each do |i, tag_attributes|
      binding.pry
      if tag_attributes[:name].present?
        tag = Tag.all.find_or_create_by(name: tag_attributes[:name])
        if !self.tags.include?(tag)
          self.post_tags.build(:tag => tag)
        end
      end

    end
  end

end
