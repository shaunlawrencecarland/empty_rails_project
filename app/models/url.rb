class Url < ApplicationRecord
  validates_format_of :path, with: UrlHelper.url_regex,
    :message => "URL is in an invalid format"
end
