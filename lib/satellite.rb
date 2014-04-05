require 'gosu'

require 'satellite/window'

module Satellite
  def self.start
    w = Window.new
    w.show
  end
end
