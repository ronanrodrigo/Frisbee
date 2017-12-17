Pod::Spec.new do |s|
  s.name = "Frisbee"
  s.version = "0.0.23"
  s.summary = "Another network wrapper for URLSession"
  s.description = "Built to make it easy to create tests for your application's network layer."
  s.homepage = "https://github.com/ronanrodrigo/Frisbee"
  s.license = {:type => "MIT", :file => "LICENSE"}
  s.author = {"Ronan Rodrigo Nunes" => "ronan.nunes@me.com"}
  s.social_media_url = "https://twitter.com/ronanrodrigon"
  s.ios.deployment_target = "10.0"
  s.osx.deployment_target = "10.13"
  s.source = { :git => "https://github.com/ronanrodrigo/Frisbee.git", :tag => "#{s.version}" }
  s.source_files = "Sources/**/*.{swift}"
  s.exclude_files = "Tests"
end
