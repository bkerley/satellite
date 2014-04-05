module Satellite
  class Window < Gosu::Window
    attr_accessor :music

    def initialize
      super 800, 600, false
      self.caption = 'satellite'

      @mars = Gosu::Image.new self, 'media/mars surface.png', true

      Signal.instance.window = self

      @sprites = [
                  Station.new(self),
                  Dish.new(self),
                  Probe.new(self)
                 ]

      self.music = Music.new self
      self.music.play
    end

    def update
      @sprites.each(&:update)

      Signal.instance.update
    end

    def draw
      @mars.draw -112, 472, 0

      @sprites.each(&:draw)

      Signal.instance.draw
    end
  end
end
