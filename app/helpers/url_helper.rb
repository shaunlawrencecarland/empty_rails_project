module UrlHelper
  CHARS = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0)

  class << self
    def encode(i)
      slug = ''

      while i > 0 do
        slug.prepend(CHARS[i.modulo(CHARS.length)])
        i = i / CHARS.length
      end

      slug
    end

    def decode(slug)
      base_10 = 0
      slug.chars.each_with_index do |c,i|
        base_10 += CHARS.index(c)* (CHARS.length**i)
      end
      base_10
    end
 
    def url_regex
      /\A[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)\z/
    end

    def slug_regex
      /\A[a-zA-Z0-9]+\z/
    end
  end
end
