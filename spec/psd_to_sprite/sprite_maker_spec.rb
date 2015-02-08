require 'spec_helper'

module PsdToSprite
  describe SpriteMaker do
    PATH_TO_PNG = "spec/support/example.png"
    LAYER_COUNT = 13
    FRAME_WIDTH = 32
    FRAME_HEIGHT = 48

    let(:psd_path) { '' }
    let(:maker) { SpriteMaker.new(psd_path) }

    describe "#process" do
      subject { maker.process }

      context "when psd does not exist" do
        it "fails hard" do
          expect { subject }.to raise_error
        end
      end

      context "when psd does exist" do
        let(:psd_path) { 'spec/support/example.psd' }
        let(:output_image) { Magick::Image.read(PATH_TO_PNG).first }

        it "does not fail hard" do
          expect { subject }.to_not raise_error
        end

        it "creates example.png" do
          path = Pathname.new(PATH_TO_PNG)
          expect { subject }.to change { path.exist? }.to(true).from(false)
        end

        it "creates an output image wide enough for all frames" do
          subject
          expect(output_image.base_columns).to eq(LAYER_COUNT * FRAME_WIDTH)
        end

        it "creates an output file with a height of the input frame file" do
          subject
          expect(output_image.base_rows).to eq(FRAME_HEIGHT)
        end
      end
    end
  end
end
