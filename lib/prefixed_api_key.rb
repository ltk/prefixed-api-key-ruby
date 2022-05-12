require "digest"
require "securerandom"

class PrefixedApiKey
  BASE58_ALPHABET = ("0".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a - ["0", "O", "I", "l"]

  attr_reader :key_prefix, :long_token, :short_token

  def self.generate(key_prefix: "mycompany", short_token_prefix: "", short_token_length: 8, long_token_length: 24)
    new(
      key_prefix: key_prefix,
      short_token: base58_bytes(short_token_length),
      long_token: base58_bytes(long_token_length)
    )
  end

  def self.base58_bytes(n)
    # https://github.com/rails/rails/blob/3872bc0e54d32e8bf3a6299b0bfe173d94b072fc/activesupport/lib/active_support/core_ext/securerandom.rb#L19
    SecureRandom.random_bytes(n).unpack("C*").map do |byte|
      idx = byte % 64
      idx = SecureRandom.random_number(58) if idx >= 58
      BASE58_ALPHABET[idx]
    end.join
  end

  def self.parse(token)
    key_prefix, short_token, long_token = token.split("_")

    new(
      key_prefix: key_prefix,
      short_token: short_token,
      long_token: long_token
    )
  end

  def initialize(key_prefix:, long_token:, short_token:)
    @key_prefix = key_prefix
    @long_token = long_token
    @short_token = short_token
  end

  def long_token_hash
    Digest::SHA256.hexdigest(long_token)
  end

  def token
    @token ||= [key_prefix, short_token, long_token].join("_")
  end
  alias to_s token
end
