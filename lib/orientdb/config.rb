module Orientdb::config
  @@ssl = false
  @@port = 2480

  def self.database
    @@database
  end

  def self.user
    @@user
  end

  def self.password
    @@password
  end

  def self.database=(database)
    @@database = database
  end

  def self.user=(username)
    @@user = username
  end

  def self.password=(password)
    @@password = password
  end

  def self.host=(host)
    @@host = host
  end

  def self.port=(port)
    @@port = port
  end

  def self.ssl=(ssl)
    @@ssl = ssl
  end

  def self.host
    @@host
  end

  def self.port
    @@port || 2480
  end

  def self.ssl
    @@ssl || false
  end

end
