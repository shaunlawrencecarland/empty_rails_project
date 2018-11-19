require 'pry'
class Url < ApplicationRecord
  URL_REGEX = /[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)/
  SLUG_REGEX = /^[a-zA-Z0-9]+$/

  ENCODING_CHARS = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0)
  ENCODING_BASE = ENCODING_CHARS.length

  def self.valid_slug?(slug)
    !!(slug.match(SLUG_REGEX))
  end
  # Take in a given URL and determine if it is a valid URL
  # Input [String] url
  # Output [Boolean]
  def self.valid_url?(url)
    !!(url.match(URL_REGEX))
  end

  # TODO: Edit this method documentation
  # Take in a URL and create a shortened version of the URL
  # Input: [String] url  - The full URL
  # Output: [String]
  def self.encode(id)
    UrlHelper.encode(id)

    # slug = ''
    # encoding_base = ENCODING_CHARS
    #
    # until id <= 0 do
    #   slug << ENCODING_CHARS[id.modulo(ENCODING_BASE)]
    #   id = id / ENCODING_BASE
    # end
    # slug.reverse
  end

  # TODO: Write better documentation for this
  # Take a slug (shortened URL) and return the corresponding URL
  # Input: [String] slug - The shortened URL
  # Output: [String] - The full URL

  def self.decode(slug)
    id = 0

    slug.each_char do |c|
      id = id * ENCODING_BASE + ENCODING_CHARS.index(c)
    end
    id
  end
end
