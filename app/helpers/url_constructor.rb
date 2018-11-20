class UrlConstructor
  def self.create!(path)
    url = Url.new(path: path)
    ActiveRecord::Base.transaction do
      if url.valid?
        url.save!
        url.slug = UrlHelper.encode(url.id)
        url.save!
      end 
    end
    url
  end
end
