FactoryBot.define do
  factory :link do
    url { "https://www.netguru.com/codestories/flutter-bloc" }
    slug {  }
    clicked { 0 }
    title { "Sample Title" }

    trait :malformed_url do
      url { "   www.BOO.com   " }
    end

    trait :nil_slug do
      slug { nil }
    end

    trait :feeble_slug do
      slug { "feeble" }
    end
  end


end
