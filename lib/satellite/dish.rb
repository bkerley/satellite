# -*- coding: utf-8 -*-
module Satellite
  class Dish < Sprite
    attr_accessor :angle
    
    def initialize(window)
      super window
      Signal.instance.dish = self

      load_image 'dish.png'
      self.angle = 90
    end

    def update
      if window.button_down? Gosu::KbLeft
        @angle += 1
      elsif window.button_down? Gosu::KbRight
        @angle -= 1
      end

      if @angle > 180
        @angle = 180
      elsif @angle < 0
        @angle = 0
      end
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
