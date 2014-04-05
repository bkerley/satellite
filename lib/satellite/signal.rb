# -*- coding: utf-8 -*-
module Satellite
  class Signal
    include Singleton

    attr_accessor :dish, :probe, :window

    GOAL = 300

    def initialize
      @score = 0
      @best_score = 0
      @last_frame = 1
      @timer = 1
      @last_cycle = 0
      @possibility = 0

      @hit_goal = false
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
      @last_frame = Time.now.to_f - @timer
      @timer = Time.now.to_f
      @line = 0
      @possibility += 1
      @score += 1 if acceptable?
      @best_score = @score if @score > @best_score
      check_goal
      reset if probe.did_reset
    end

    def draw
      write_line "Difficulty: %1.2f" % Stage.instance.difficulty

      lazer if acceptable?
      if @hit_goal
        draw_winning
      else
        draw_progress
      end
    end

    private
    def reset
      @last_cycle = (@score * 100) / @possibility
      @score = 0
      @possiblity = 0
      @hit_goal = false
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
      @big = Gosu::Font.new(window, 'media/Ubuntu-Regular.ttf', 32)
    end

    def setup_lazer
      @lazer = Lazer.new dish
    end

    def check_goal
      return if @hit_goal
      if @score > GOAL
        @hit_goal = true
        Stage.instance.winning = true
      end
    end

    def draw_doof
      
    end

    def draw_progress
      w = 800 * (@score.to_f / GOAL)
      t = (window.height - 48) - (16 * window.music.beat)
      b = window.height

      window.draw_quad(0, t, Gosu::Color::GREEN,
                       w, t, Gosu::Color::GREEN,
                       0, b, Gosu::Color::BLACK,
                       w, b, Gosu::Color::BLACK
                       )
    end

    def draw_winning
      m = "DOWNLOAD SUCCESSFUL"
      w = @big.text_width m
      b = window.music.beat
      left = (window.width - w) / 2
      top = (window.height - 48) - (16 * b)
      @big.draw("DOWNLOAD SUCCESSFUL", 
                left, top, 1, 
                1, 1 + b)
    end
  end
end
