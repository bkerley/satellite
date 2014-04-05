module Satellite
  class Lazer
    def initialize(dish)
      @dish = dish
      @window = dish.window
      @image = Gosu::Image.new @window, 'media/binary.png', true
    end

    def draw(distance)
      angle = -@dish.angle

      scale = distance / @image.width

      @image.draw_rot(@dish.center, @dish.base, 0,
                      angle, 0, 0.5, scale, @window.music.beat + 1)
    end
  end
end
