class Link < ApplicationRecord
    validates_presence_of :url
    validates :url, format: URI::regexp(%w[http https www])
    validates_uniqueness_of :slug
    validates_length_of :url, within: 3..255, on: :create, message: "too long"

    # before_validation :generate_slug
    before_save :sanitize

    after_save :generate_slug
    after_commit :retrieve_title

    def shortened_url
        ENV['DOMAIN'] + self.slug
    end

    private
    ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)

    def generate_slug
        s = ''
        base = ALPHABET.length
        while self.id > 0
          s << ALPHABET[self.id.modulo(base)]
          self.id /= base
        end
        self.update_column(:slug, s.reverse)
    end

    def sanitize
        self.url ||= ""
        self.url.try(:strip!)
        sanitize_url = self.url.downcase.gsub(/(www\.)/,"")
    end

    def retrieve_title
        ScraperJob.perform_later(self.url,self.slug)
    end
end
