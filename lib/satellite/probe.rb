module Satellite
  class Probe < Sprite
    attr_reader :x, :y, :d_x, :did_reset
    def initialize(window)
      super window
      Signal.instance.probe = self
      Stage.instance.probe = self

      load_image 'probe.png'

      @x = window.width + rand(64)

      start_position
      pick_angle
    end

    def update
      @x -= @d_x
      @angle += @d_angle
      @did_reset = false

      if (@x < -image.width) || (@x > window.width + image.width)
        @did_reset = true
        start_position
        pick_angle
      end
    end

    def draw
      image.draw_rot(@x, @y, 1, @angle)
    end

    private

    def start_position
      Stage.instance.next_stage

      @y = (400 * Stage.instance.probe_altitude) + 20

      sign = @d_x / @d_x.abs rescue -1

      @d_x = Stage.instance.probe_speed * (-sign)
    end

    def pick_angle
      @angle = rand(360)
      @d_angle = (rand * 2) - 1
    end
  end
end
