# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "libwebsocket"
  s.version = "0.1.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bernard Potocki"]
  s.date = "2012-11-19"
  s.description = "Universal Ruby library to handle WebSocket protocol"
  s.email = ["bernard.potocki@imanel.org"]
  s.homepage = "http://github.com/imanel/libwebsocket"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Universal Ruby library to handle WebSocket protocol"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<websocket>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<websocket>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<websocket>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
