module Satellite
  class Window < Gosu::Window
    def initialize
      super 800, 600, false
      self.caption = 'satellite'

      @mars = Gosu::Image.new self, 'media/mars surface.png', true

      @sprites = []

      @sprites << Station.new(self)
      @sprites << Dish.new(self)
    end

    def update
      @sprites.each(&:update)
    end

    def draw
      black = Gosu::Color::BLACK
      draw_quad(0, 0, black,
                self.width, 0, black,
                self.width, self.height, black,
                0, self.height, black)
      @mars.draw -112, 472, 0

      @sprites.each(&:draw)
    end
  end
end
