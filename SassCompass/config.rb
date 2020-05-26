require "compass/import-once/activate"
# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path = "../"
css_dir = "css"
sass_dir = "sass"
fonts_dir = "css/fonts"
output_style = :compressed
#output_style = :expanded
javascripts_dir = "js"
images_dir = "images"
generated_images_dir = "images/interface"
Encoding.default_external = 'utf-8'


# Make a copy of sprites with a name that has no uniqueness of the hash.
#on_sprite_saved do |filename|
#  if File.exists?(filename)
#    FileUtils.cp filename, filename.gsub(%r{-s[a-z0-9]{10}\.png$}, '.png')
#    # Note: Compass outputs both with and without random hash images.
#    # To not keep the one with hash, add: (Thanks to RaphaelDDL for this)
#    FileUtils.rm_rf(filename)
#  end
#end
# 
## Replace in stylesheets generated references to sprites
## by their counterparts without the hash uniqueness.
#on_stylesheet_saved do |filename|
#  if File.exists?(filename)
#    css = File.read filename
#    File.open(filename, 'w+') do |f|
#      f << css.gsub(%r{-s[a-z0-9]{10}\.png}, '.png')
#    end
#  end
#end

# To enable relative paths to assets via compass helper functions. Uncomment:
relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

require 'sass'
require 'cgi'

module Sass::Script::Functions

  def inline_svg_image(path, fill)
    real_path = File.join(Compass.configuration.images_path, path.value)
    svg = data(real_path)

    colors_e= fill.to_s.split(" ")

    colors_e.each_with_index do |m, i|
        svg.gsub! "{color_#{i}}", "#{m}"
    end

    encoded_svg = CGI::escape(svg).gsub('+', '%20')
    data_url = "url('data:image/svg+xml;charset=utf-8," + encoded_svg + "')"
    Sass::Script::String.new(data_url)
  end

private

  def data(real_path)
    if File.readable?(real_path)
      File.open(real_path, "rb") {|io| io.read}
    else
      raise Compass::Error, "File not found or cannot be read: #{real_path}"
    end
  end

end
