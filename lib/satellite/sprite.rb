module Satellite
  class Sprite
    attr_accessor :window, :image

    def initialize(window)
      self.window = window
    end

    def update
    end

    def draw
    end

    def load_image(filename)
      self.image = Gosu::Image.new window, "media/#{filename}", true
    end
  end
end
