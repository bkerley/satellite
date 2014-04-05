# -*- coding: utf-8 -*-
module Satellite
  class Dish < Sprite
    def initialize(window)
      super window
      
      load_image 'dish.png'
      @angle = 0

      @font = Gosu::Font.new(window, 'media/UbuntuMono-Regular.ttf', 24)
    end

    def update
      @angle = (@angle + 1) % 180
    end

    def draw
      left = (window.width / 2) #- (image.width / 2)
      top = window.height - 110
      angle = - @angle 

      image.draw_rot(left, top, 0, angle, 0.25, 0.5)

      @font.draw("Angle: %3d°" % @angle,
                 4, 0, 0)
    end
  end
end
