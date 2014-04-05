require 'gosu'

%w{window sprite station dish}.each do |f|
  require "satellite/#{f}"
end

module Satellite
  def self.start
    w = Window.new
    w.show
  end
end
