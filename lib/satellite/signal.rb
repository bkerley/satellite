# -*- coding: utf-8 -*-
module Satellite
  class Signal
    include Singleton

    attr_accessor :dish, :probe, :window

    def initialize
      @score = 0
      @best_score = 0
    end

    def angle_difference
      dish_angle - probe_angle
    end

    def dish_angle
      dish.angle
    end

    def probe_angle
      a = Math.atan(-dy / dx) * (180.0 / Math::PI)
      if a < 0
        a = 180 + a
      end

      return a
    end

    def signal_strength
      divisor = ((angle_difference / 16) ** 2) + 1
      1.0 / divisor
    end

    def acceptable?
      signal_strength > 0.5
    end

    def dx
      probe.x.to_f - dish.center
    end

    def dy
      probe.y.to_f - dish.base
    end

    def distance
      Math.sqrt((dx ** 2) + (dy ** 2))
    end

    def window=(value)
      @window = value
      setup_font
    end

    def dish=(value)
      @dish = value
      setup_lazer
    end

    def update
      @line = 0
      @score += 1 if acceptable?
      @best_score = @score if @score > @best_score
      reset if probe.did_reset
    end

    def draw
      write_line sprintf("Score: %d       Best: %d", @score, @best_score)
      write_line "Dish Angle: %3d°" % dish_angle
      write_line "Probe angle to dish: %3d°" % probe_angle
      write_line "Difference: %3d°" % angle_difference
      write_line "Signal strength: %.0f%%" % (signal_strength * 100)
      write_line "Receiving: #{acceptable?}"
      write_line "Beat: %.04f" % window.music.beat

      lazer if acceptable?
    end

    private
    def reset
      @score = 0
    end

    def write_line(text)
      @font.draw(text, 4, @line, 1)
      @line += @font.height
    end
    
    def lazer
      @lazer.draw distance
    end

    def setup_font
      @font = Gosu::Font.new(window, 'media/UbuntuMono-Regular.ttf', 16)
    end

    def setup_lazer
      @lazer = Lazer.new dish
    end
  end
end
