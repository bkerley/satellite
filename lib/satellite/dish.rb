# -*- coding: utf-8 -*-
module Satellite
  class Dish < Sprite
    attr_accessor :angle
    
    def initialize(window)
      super window
      Signal.instance.dish = self

      load_image 'dish.png'
      self.angle = 0
    end

    def update
      self.angle = (angle + 1) % 180
    end

    def draw
      image.draw_rot(center, base, 0, display_angle, 0.25, 0.5)
    end

    def center
      window.width / 2
    end

    def base
      window.height - 110
    end

    private
    def display_angle
      -angle
    end
  end
end
