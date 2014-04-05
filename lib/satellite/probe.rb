module Satellite
  class Probe < Sprite
    attr_reader :x, :y, :did_reset
    def initialize(window)
      super window
      Signal.instance.probe = self

      load_image 'probe.png'

      start_position
      pick_angle
    end

    def update
      @x -= 1
      @angle += @d_angle
      @did_reset = false

      if @x < -image.width
        @did_reset = true
        start_position
        pick_angle
      end
    end

    def draw
      image.draw_rot(@x, @y, 0, @angle)
    end

    private

    def start_position
      @x = window.width + rand(128)
      @y = rand(256)
    end

    def pick_angle
      @angle = rand(360)
      @d_angle = (rand * 2) - 1
    end
  end
end
