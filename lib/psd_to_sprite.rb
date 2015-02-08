require 'psd_to_sprite/version'
require 'pathname'
require 'psd'
require 'rmagick'

module PsdToSprite
  class SpriteMaker
    attr_reader :frame_width, :frame_height, :layers, :path, :psd

    def initialize(psd_path)
      @path = Pathname.new(psd_path)
      @psd = PSD.new(psd_path)
    end

    def process(output_path = nil)
      psd.parse!
      root_node = psd.tree
      @frame_height = root_node.height
      @frame_width = root_node.width
      @layers = psd.layers

      output_width = root_node.children.count * frame_width

      img  = save_layers_to_new_image(output_width, frame_height)

      return img.write(output_path) if output_path
      img.write("#{path.dirname}/#{filename_without_ext}.png")
    end

    private
    def filename_without_ext
      path.basename.to_s.gsub(path.extname, "")
    end

    def save_layers_to_new_image(output_width, output_height)
      img = Magick::Image.new(output_width, output_height) do
        self.background_color = "transparent"
      end

      x = 0
      y = 0

      layers.reverse.each do |layer|
        frame = layer.image.to_png
        frame_img = Magick::Image.from_blob(frame.to_s).first

        img = img.composite(frame_img, x, layer.top, Magick::AddCompositeOp)
        x += frame_width
      end
      img
    end
  end
end
