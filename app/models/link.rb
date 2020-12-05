class Link < ApplicationRecord
    validates_presence_of :url
    validates :url, format: URI::regexp(%w[http https www])
    validates_uniqueness_of :slug
    validates_length_of :url, within: 3..255, on: :create, message: "too long"

    before_validation :generate_slug
    before_save :sanitize

    def generate_slug
        self.slug = SecureRandom.uuid[0..5] if self.slug.nil? || self.slug.empty?
    end

    def sanitize
        self.url ||= ""
        self.url.try(:strip!)
        sanitize_url = self.url.downcase.gsub(/(www\.)/,"")
    end

    def shortened_url
        ENV['DOMAIN'] + self.slug
    end
end
