class UrlConstructor
  def self.create!(path)
    @url = Url.new(path: path)

    ActiveRecord::Base.transaction do
      begin
        if @url.valid?
          # if !path_already_exists?
            break unless save_url!
            @slug = UrlHelper.encode(@url.id)
            @url.slug = UrlHelper.encode(@url.id)
            break unless save_url!
          # end
        end
      rescue ActiveRecord::RecordNotUnique => e
        existing_url = Url.find_by(path: @path)
        # existing_url = Url.where(path: @url.path)
        #
        # # first_ex = existing_url.first
        # # puts "~~~: #{existing_url}"
        # # first =
        # # existing_slug = existing_url.slug
        msg = "existing_url: #{existing_url.to_json} error to s: #{e.to_s} error inspect: #{e.inspect} error cause: #{e.cause} "
        # msg = "URL #{path} already exists.  Its slug is #{existing_url.slug}"
        @url.errors.add(:path, msg)
      end
    end
    @url
  end

  def self.path_already_exists?
    existing_url = Url.find_by(path: @url.path)

    if existing_url.present?
      # boom = 1/0
      msg = "URL #{path} already exists.  Its slug is #{existing_url.slug}"
      @url.errors.add(:path, msg)
      true
    else
      false
    end
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
