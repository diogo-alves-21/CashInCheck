class UrlValidator < ActiveModel::EachValidator

  # example: validates :url, url: true

  def validate_each(record, attribute, value)
    record.errors.add(attribute, :must_be_a_url) unless url_valid?(value)
  end

  # a URL may be technically well-formed but may
  # not actually be valid, so this checks for both.
  def url_valid?(url)
    return true if url.blank?

    url = begin
      URI.parse(url)
    rescue StandardError
      false
    end
    url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  end

end
