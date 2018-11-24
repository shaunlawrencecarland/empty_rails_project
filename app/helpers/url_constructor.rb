class UrlConstructor
  class << self
    def create!(path)
      @path = path
      prepend_path_with_protocol_if_missing!

      @url = Url.find_or_initialize_by(path: @path)
      return @url unless @url.new_record?

      ActiveRecord::Base.transaction do
        if @url.valid?
          break unless save_url!
          @url.slug = UrlHelper.encode(@url.id)
          break unless save_url!
        end
      end
      @url
    end

    def save_url!
      if @url.save!
        return true
      else
        @url.errors.add(:path, "Error: URL could not be saved for an unknown reason")
        return false
      end
    end

    def prepend_path_with_protocol_if_missing!
      unless @path[/\Ahttp:\/\//] || @path[/\Ahttps:\/\//]
        @path = "http://#{@path}"
      end
    end
  end
end
