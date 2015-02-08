require 'psd_to_sprite/version'
require 'pathname'
require 'psd'
require 'rmagick'

module PsdToSprite
  class SpriteMaker
    attr_reader :frame_width, :frame_height, :path, :psd

    def initialize(psd_path)
      @path = Pathname.new(psd_path)
      @psd = PSD.new(psd_path)
    end

    def process(output_path = nil)
      psd.parse!
      root_node = psd.tree
      @frame_height = root_node.height
      @frame_width = root_node.width

      output_width = root_node.children.count * frame_width

      pngs = collect_pngs_from_layers(root_node.children)
      img  = save_pngs_to_new_image(pngs, output_width, frame_height)

      return img.write(output_path) if output_path
      img.write("#{path.dirname}/#{filename_without_ext}.png")
    end

    private
    def filename_without_ext
      path.basename.to_s.gsub(path.extname, "")
    end

    def collect_pngs_from_layers(layers)
      pngs = []
      layers.each do |layer|
        pngs << layer.to_png
      end
      pngs
    end

    def save_pngs_to_new_image(pngs, output_width, output_height)
      img = Magick::Image.new(output_width, output_height) do
        self.background_color = "transparent"
      end

      x = 0
      y = 0

      pngs.each do |frame|
        frame_img = Magick::Image.from_blob(frame.to_s).first
        img = img.composite(frame_img, x, y, Magick::AddCompositeOp)
        x += frame_width
      end
      img
    end
  end
end
