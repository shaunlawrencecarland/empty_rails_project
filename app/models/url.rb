class Url < ApplicationRecord
  before_create :prepend_path_with_protocol_if_missing

  validates_format_of :path, with: UrlHelper.url_regex,
    :message => "URL is in an invalid format"

  protected
  def prepend_path_with_protocol_if_missing
    unless self.path[/\Ahttp:\/\//] || self.path[/\Ahttps:\/\//]
      self.path = "http://#{self.path}"
    end
  end
end
