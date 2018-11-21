class UrlConstructor
  def self.create!(path)
    @url = Url.new(path: path)

    ActiveRecord::Base.transaction do
      begin
        if @url.valid?
          break unless save_url!
          @url.slug = UrlHelper.encode(@url.id)
          break unless save_url!
        end
      rescue ActiveRecord::RecordNotUnique => e
        puts "we're inside the record not unique rescue block..."
        existing_slug = UrlHelper.decode(@url.id)
        # existing_url = Url.where(path: @url.path).first
        msg = "URL #{path} already exists.  Its slug is #{existing_slug}"
        msg = "URL Already exists"
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
