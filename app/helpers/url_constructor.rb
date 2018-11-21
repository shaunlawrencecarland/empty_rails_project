class UrlConstructor
  def self.create!(path)
    @url = Url.new(path: path)

    ActiveRecord::Base.transaction do
      begin
        if @url.valid?
          break unless save_url!
          @slug = UrlHelper.encode(@url.id)
          @url.slug = UrlHelper.encode(@url.id)
          break unless save_url!
        end
      rescue ActiveRecord::RecordNotUnique => e
        existing_url = Url.where(path: path).first
        existing_slug = Url.where(path: path).slug
        msg = "foo"
        # msg = "URL #{path} already exists.  Its slug is #{existing_url.slug}"
        @url.errors.add(:path, msg)
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
end
