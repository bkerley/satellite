require 'pp'
require 'gosu'
require 'singleton'

%w{window sprite station dish probe signal lazer music}.each do |f|
  require "satellite/#{f}"
end

module Satellite
  def self.start
    w = Window.new
    w.show
  end
end
