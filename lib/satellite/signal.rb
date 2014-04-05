# -*- coding: utf-8 -*-
module Satellite
  class Signal
    include Singleton

    attr_accessor :dish, :probe, :window

    def initialize
    end

    def angle_difference
      dish_angle - probe_angle
    end

    def dish_angle
      dish.angle
    end

    def probe_angle
      dx = probe.x.to_f - dish.center
      dy = probe.y.to_f - dish.base
      a = Math.atan(-dy / dx) * (180.0 / Math::PI)
      if a < 0
        a = 180 + a
      end

      return a
    end

    def signal_strength
      divisor = ((angle_difference / 4) ** 2) + 1
      1.0 / divisor
    end

    def acceptable?
      signal_strength > 0.5
    end

    def window=(value)
      @window = value
      setup_font
    end

    def update
      @line = 0
    end

    def draw
      write_line "Dish Angle: %3d°" % dish_angle
      write_line "Probe angle to dish: %3d°" % probe_angle
      write_line "Difference: %3d°" % angle_difference
      write_line "Signal strength: %f%%" % (signal_strength * 100)
      write_line "Receiving: #{acceptable?}"

      lazer if angle_difference.abs < 5
    end

    private
    def write_line(text)
      @font.draw(text, 4, @line, 1)
      @line += @font.height
    end
    
    def lazer
      window.draw_line(probe.x, probe.y, Gosu::Color::RED,
                       dish.center, dish.base, Gosu::Color::RED,
                       -1)
    end

    def setup_font
      @font = Gosu::Font.new(window, 'media/UbuntuMono-Regular.ttf', 16)
    end
  end
end
