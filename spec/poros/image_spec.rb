require 'rails_helper'

RSpec.describe 'Image PORO' do
  it 'can select out the info needed from the API call' do
    image_data = {:id=>"yJ2SHIpNb9M",
    :created_at=>"2018-10-27T03:32:26Z",
    :updated_at=>"2022-11-13T01:05:52Z",
    :promoted_at=>nil,
    :width=>3888,
    :height=>2184,
    :color=>"#f3d9c0",
    :blur_hash=>"LnGSx=%KaKoJ~pxZodoL#Qaet7j[",
    :description=>"The picture taken in Laos, 06:00, from hot baloon",
    :alt_description=>"time lapse photography of flying hot air balloon",
    :urls=>
     {:raw=>
       "https://images.unsplash.com/photo-1540611025311-01df3cef54b5?ixid=MnwzODAwNzN8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTY2ODM1NzgxNw&ixlib=rb-4.0.3",
      :full=>
       "https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzODAwNzN8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTY2ODM1NzgxNw&ixlib=rb-4.0.3&q=80",
      :regular=>
       "https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzODAwNzN8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTY2ODM1NzgxNw&ixlib=rb-4.0.3&q=80&w=1080",
      :small=>
       "https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzODAwNzN8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTY2ODM1NzgxNw&ixlib=rb-4.0.3&q=80&w=400",
      :thumb=>
       "https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzODAwNzN8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTY2ODM1NzgxNw&ixlib=rb-4.0.3&q=80&w=200",
      :small_s3=>
       "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1540611025311-01df3cef54b5"}}

    image = Image.new(image_data)

    expect(image.alt_tag).to eq(image_data[:alt_description])
    expect(image.url).to eq(image_data[:urls][:raw])
    expect(image.instance_variables).to eq(%i[@alt_tag @url])
  end
end