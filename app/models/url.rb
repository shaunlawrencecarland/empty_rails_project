class Url < ApplicationRecord

  # Take in a given URL and determine if it is a valid URL
  # Input [String] url
  # Output [Boolean]
  def self.valid_url?(url)
  end
  # Take in a URL and create a shortened version of the URL
  # Input: [String] url  - The full URL
  # Output: [String]
  def self.encode(url)

  end

  # Take a slug (shortened URL) and return the corresponding URL
  # Input: [String] slug - The shortened URL
  # Output: [String] - The full URL

  def self.decode(slug)
  end
end
