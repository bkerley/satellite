module Satellite
  class Mars
    def initialize(window)
      @window = window
      @image = Gosu::Image.new @window, 'media/mars surface.png', true
    end

    def draw
      scale = 1 #+ (@window.music.beat * 0.25)
      v_scale = 1 - (@window.music.beat * 0.05)
      x = (@window.width - (scale * @image.width)) / 2
      y = @window.height - (v_scale * @image.height)
      
      @image.draw x, y, 0, scale, v_scale
    end
  end
end
