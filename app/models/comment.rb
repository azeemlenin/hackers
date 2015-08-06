class Comment < ActiveRecord::Base
  # # Remember to create a migration!
  # has_many :comments
  belongs_to :parent_comment
  belongs_to :post
  belongs_to :user
  validates :body, presence: true
  def parent_comment
    Comment.find(parent_id)
  end

end
