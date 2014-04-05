module Satellite
  class Mars
    def initialize(window)
      @window = window
      @image = Gosu::Image.new @window, 'media/mars surface.png', true
    end

    def draw
      scale = 1 + (@window.music.beat * 0.25)
      x = (@window.width - (scale * @image.width)) / 2
      y = @window.height - @image.height
      
      @image.draw x, y, 0, scale
    end
  end
end
