class UrlConstructor
  def self.create!(path)
    @path = path
    prepend_path_with_protocol_if_missing

    @url = Url.find_or_initialize_by(path: @path)

    if @url.slug
       msg = "URL #{path} already exists.  Its slug is #{@url.slug}"
       return @url
    end

    ActiveRecord::Base.transaction do
      if @url.valid?
          break unless save_url!
          @slug = UrlHelper.encode(@url.id)
          @url.slug = UrlHelper.encode(@url.id)
          break unless save_url!
      end
    end
    @url
  end

  def self.save_url!
    if @url.save!
      return true
    else
      @url.errors.add(:base, "Error: URL could not be saved for an unknown reason")
      return false
    end
  end

  def self.prepend_path_with_protocol_if_missing
    unless @path[/\Ahttp:\/\//] || @path[/\Ahttps:\/\//]
      @path = "http://#{@path}"
    end
  end
end
