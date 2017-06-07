class User < ActiveRecord::Base
  
  attr_accessor :remember_token
  validates :email,  presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
                    
  validates :firstname,  presence: true, length: { maximum: 50 }
  validates :lastname,  presence: true, length: { maximum: 50 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }, allow_nil: true
  
  mount_uploader :picture, PictureUploader
  validate  :picture_size

 

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
    Answer.where("user_id = ?", id)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def create_avatar_for_user
    image_user = self
    
    filename = image_user.email.gsub('@','_')+'.png'
    
    img = Avatarly.generate_avatar(image_user.firstname+" "+image_user.lastname, opts={})
    path_to_image = 'public/uploads/user/'+image_user.id.to_s+'/'+filename
    dirname = File.dirname(path_to_image)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
    File.open(path_to_image, 'wb') do |f|
      f.write img
    end
    
    self.picture = filename
    self.save!
  end
  
  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
  
end