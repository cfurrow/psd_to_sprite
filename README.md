# PsdToSprite

Convert a PSD with layers to a single sprite sheet for animations

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'psd_to_sprite'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install psd_to_sprite

## Usage

This gem takes a Photoshop file (PSD) that has layers, all the same size, and outputs
each layer into a horizontal sprite sheet, with each layer laid next to the other,
left to right. The ordering of the layers in your PSD will dictate the ordering
of the sprites in the output png. The layer at the very bottom will become frame 0,
the next one frame 1, and so on.

```ruby
require 'psd_to_sprite'

sprite_maker = PsdToSprite::SpriteMaker.new("example.psd")
sprite_maker.process # => outputs to example.png
sprite_maker.process("foo.png") #=> outputs to foo.png
```

### Output example

*Note: Example image comes from the [Phaser.js](http://phaser.io/) project*

![example](example/example.png)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/psd_to_sprite/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write specs
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
