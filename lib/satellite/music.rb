module Satellite
  class Music
    attr_accessor :window, :song, :start

    BPM = 155.0
    SPB = 1 / (BPM / 60)
    MSPB = SPB * 1000

    OFFSET = 0

    def initialize(window)
      self.window = window
      self.song = Gosu::Song.new self.window, 'media/satellite loop.mp3'
#      song.volume = 0
    end

    def update
      play unless self.song.playing?
    end

    def play
      self.song.play
      self.start = now
    end

    def beat
      peaky((current.to_i % MSPB) / MSPB)
    end

    private
    def peaky(x)
      Math.sin((x + OFFSET) * Math::PI) ** 20
    end

    def current
      now - start
    end

    def now
      Time.now.to_f * 1000
    end
  end
end
