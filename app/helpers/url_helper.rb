module UrlHelper
  CHARS = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0)

  class << self
    def encode(i)
      slug = ''

      while i > 0 do
        slug += CHARS[i.modulo(CHARS.length)]
        i = i / CHARS.length
      end

      slug.reverse
    end

    def decode(slug)
      slug.each_char.inject(0) { |i,c| i * CHARS.length + CHARS.index(c) }
    end

    def url_regex
      /\A[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)\z/
    end

    def slug_regex
      /^[a-zA-Z0-9]+$/
    end
  end
end
