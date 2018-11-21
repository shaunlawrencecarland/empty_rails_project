class UrlConstructor
  def self.create!(path)
    url = Url.new(path: path)

    ActiveRecord::Base.transaction do
      begin
        if url.valid?
          url.save!
          url.slug = UrlHelper.encode(url.id)
          url.save!
        end
      rescue ActiveRecord::RecordNotUnique => e
        # binding.pry
        existing_url = Url.where(path: url.path).first
        msg = "URL #{path} already exists.  Its slug is #{existing_url.slug}"
        url.errors.add(:path, msg)
      end
    end
    url
  end
end
