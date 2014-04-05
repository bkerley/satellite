module Satellite
  class Stage
    include Singleton

    attr_accessor :window, :probe, :probe_speed, :probe_altitude, :difficulty, :winning

    def initialize
      self.winning = false
      next_stage
    end

    def next_stage
      return start_over unless winning
      self.difficulty += 0.1 * rand
      self.difficulty = 1 if difficulty > 1

      split = rand

      self.probe_speed = (1.15 + (difficulty * split)) ** 2
      self.probe_altitude = difficulty * (1 - split)
      self.winning = false
    end

    def start_over
      self.difficulty = 0.1
      self.winning = true
      next_stage
    end
  end
end
