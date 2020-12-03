FactoryBot.define do
  factory :link do
    url { "https://www.netguru.com/codestories/flutter-bloc" }
    slug { "flutter" }
    clicked { 0 }
    title { "Sample Title" }
  end
end
