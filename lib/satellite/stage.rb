module Satellite
  class Stage
    include Singleton

    attr_accessor :window, :probe, :probe_speed, :probe_altitude, :difficulty

    def initialize
      self.difficulty = 0
      next_stage
    end

    def next_stage
      self.difficulty += (rand * 0.2)

      split = rand

      self.probe_speed = (1.15 + (difficulty * split)) ** 2
      self.probe_altitude = difficulty * (1 - split)
    end
  end
end
