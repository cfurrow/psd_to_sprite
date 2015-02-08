require 'psd_to_sprite'
require 'pathname'
require 'pry'
require 'rmagick'

RSpec.configure do |c|
  c.color = true

  c.before(:each) do
    path = Pathname.new("spec/support/example.png")
    path.delete if path.exist?
  end
end
