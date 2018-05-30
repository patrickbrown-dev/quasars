class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "is not a URL") unless is_url?(value) || value.empty?
  end

  private
  def is_url?(value)
    uri = URI.parse(value)
    %w(http https).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end
