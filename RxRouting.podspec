Pod::Spec.new do |s|
  s.name           = "RxRouting"
  s.version        = "1.0.0"
  s.platform       = :ios
  s.ios.deployment_target = "10.0"
  s.summary        = "Deeplink routing"
  s.author         = { "Bas van Kuijck" => "bas@e-sites.nl" }
  s.license        = { :type => "MIT", :file => "LICENSE" }
  s.homepage       = "https://github.com/e-sites/#{s.name}"
  s.source         = { :git => "https://github.com/e-sites/#{s.name}.git", :tag => "v#{s.version.to_s}" }
  s.source_files   = "Sources/**/*.{h,swift}"
  s.requires_arc   = true
  s.frameworks     = 'Foundation'
  s.dependency 'RxSwift', '~> 5.0'
  s.swift_versions = [ '5.0' ]
end
