# prefixed-api-key-ruby

A Ruby implementation of https://github.com/seamapi/prefixed-api-key

## Usage
```ruby
PrefixedApiKey.generate(key_prefix: "ltk")
# => "ltk_WBB61Bfd_P5g2eKGnqkNsy3bT8Trf7shD"

key = PrefixedApiKey.parse("ltk_WBB61Bfd_P5g2eKGnqkNsy3bT8Trf7shD")
# => #<PrefixedApiKey:...>

key.key_prefix
# => "ltk"

key.short_token
# => "WBB61Bfd"

key.long_token
# => "P5g2eKGnqkNsy3bT8Trf7shD"

key.long_token_hash
# => "2a094d98f016a582040b019dcc3b1f4afe7f7f95ae696e625ca5da2bc6f2c966"