class Bookmark < ActiveRecord::Base
  def password
    @password
  end

  def password=(pass)
    @password = pass
    self.salt = User.random_string(10) if !self.salt?
    self.hash_password = User.encrypt(@password, self.salt)
  end
  

  def self.authenticate(login, password)
    #u = find(:first, :conditions => ["name = ?", name])
    u = find(:first, :conditions => { :name => "#{login}" })
    return nil if u.nil?
    return u if User.encrypt(password, u.salt) == u.hash_password
    nil
  end

  protected

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt) 
  end
end
