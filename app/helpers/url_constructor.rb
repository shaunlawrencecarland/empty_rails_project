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
        existing_url = Url.where(path: @url.path).limit(1)
        # first_ex = existing_url.first
        # puts "~~~: #{existing_url}"
        # first =
        # existing_slug = existing_url.slug
        msg = "error: #{e.to_s} existing_url: #{existing_url.to_s}"
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
