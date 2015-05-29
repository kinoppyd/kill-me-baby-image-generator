# coding: utf-8
require 'sinatra'
require 'rmagick'

FONT_NAME = './GN-KillGothic-U-KanaNA.ttf'

get '/' do
  erb :index
end

get '/:query' do
  img = kill_me_baby(length_check(params['query']))
  content_type 'image/png'
  img.to_blob
end

def kill_me_baby(text = 'キルミーベイベー')
  offset = 5

  draw = Magick::Draw.new
  draw.pointsize = 40
  draw.gravity = Magick::NorthWestGravity
  draw.font = FONT_NAME
  draw.fill = 'black'
  draw.stroke = 'transparent'

  metrics = draw.get_type_metrics(text)

  img = Magick::Image.new(metrics.width.ceil + offset * 2, metrics.height.ceil + offset * 2)
  draw.annotate(img, 0, 0, offset, offset, text)

  img.format = 'png'
  img
end

def length_check(text)
  text.size <= 50 ? text : '長い'
end
