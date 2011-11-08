class User < ActiveRecord::Base
  require 'digest/sha1'
  
  validates_presence_of :name, :email, :password, :password_confirmation, :salt
  validates_uniqueness_of :name, :email
  validates_length_of :name, :within => 3..40
  validates_length_of :password, :within => 6..40
  
  attr_accessor :password_confirmation
  attr_protected :id, :salt
  validates_confirmation_of :password
  
  def password
    @password
  end

  def password=(pass)
    @password = pass
    self.salt = User.random_string(10) if !self.salt?
    self.hash_password = User.encrypt(@password, self.salt)
  end
  

  def self.authenticate(login, pass)
    u = find(:first, :conditions => ["name = ?", name])
    return nil if u.nil?
    return u if User.encrypt(pass, u.salt) == u.hash_password
    nil
  end

  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.name, new_pass)
  end

  protected

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt) 
  end

  def self.random_string(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

end
