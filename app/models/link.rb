class Link < ApplicationRecord
    validates_presence_of :url
    validates :url, format: URI::regexp(%w[http https])
    validates_uniqueness_of :slug
    validates_length_of :url, within: 3..255, on: :create, message: "too long"

    before_validation :generate_slug, :sanitize

    def generate_slug
        self.slug = SecureRandom.uuid[0..5] if self.slug.nil? || self.slug.empty?
    end

    def sanitize
        url.strip!
        sanitize_url = self.url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
        "http://#{sanitize_url}"
    end
end
