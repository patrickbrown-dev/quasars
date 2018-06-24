class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if url?(value) || value.empty?

    error_attr = (options[:message] || 'is not a URL')
    record.errors[attribute] << error_attr
  end

  private

  def url?(value)
    uri = URI.parse(value)
    %w[http https].include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end
