#
require "digest/md5"

class Auth
  def initialize(auth_code = 'bd6dbd063f5ab7394879e3c08781cd72')
    @auth_code = auth_code
    @key_list  = {}
  end

  def authenticate(key, ip)
    auth_key   = Digest::MD5.hexdigest(key)
    return false unless @auth_code == auth_key

    client_key = Digest::MD5.hexdigest(auth_key+ip)
    @key_list[client_key] = ip
    return client_key
  end

  def proof(key)
    return @key_list[key] if @key_list.has_key?(key)
    return false
  end
end
