module Satellite
  class Window < Gosu::Window
    attr_accessor :music

    def initialize
      super 800, 600, false
      self.caption = 'satellite'

      @mars = Mars.new self

      Signal.instance.window = self
      Stage.instance.window = self

      @sprites = [
                  Station.new(self),
                  Dish.new(self),
                  Probe.new(self)
                 ]

      self.music = Music.new self
      self.music.play
    end

    def update
      music.update
      @sprites.each(&:update)

      Signal.instance.update
    end

    def draw
      @mars.draw

      @sprites.each(&:draw)

      Signal.instance.draw
    end
  end
end
