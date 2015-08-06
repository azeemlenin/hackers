class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :posts
  has_many :comments

  validates :email, uniqueness: true

  def self.authenticate(email, password)
    @user = User.find_by_email(email)
    if @user == []
      nil
    elsif @user.password == password
      return @user
    else
      nil
    end
  end

end
