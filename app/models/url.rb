require 'pry'
class Url < ApplicationRecord
  URL_REGEX = /[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)/
  # Take in a given URL and determine if it is a valid URL
  # Input [String] url
  # Output [Boolean]
  def self.valid_url?(url)
    !!(url.match(URL_REGEX))
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
