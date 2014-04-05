module Satellite
  class Station < Sprite
    def initialize(window)
      super window

      load_image 'station.png'
    end

    def draw
      left = (window.width / 2) - (image.width / 2)
      image.draw(left, window.height - 128, 0)
    end
  end
end
