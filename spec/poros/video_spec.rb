require 'rails_helper'

RSpec.describe 'Video PORO' do
  it 'can take only the info needed from the API return', :vcr do
    video_data = {
      kind: 'youtube#searchResult',
      etag: 'VJ8vh9PGCjSq-hQ8BFgrfvuzpZw',
      id: {
        kind: 'youtube#video',
        videoId: '0GDwDqfzWEE'
      },
      snippet: {
        publishedAt: '2022-11-11T11:45:00Z',
        channelId: 'UCO5IhWS7_CIU1HoAkffBzcg',
        title: 'Vientiane, Laos - First Impressions - Not what I expected!! 🇱🇦',
        description: 'Today is my first Day in Vientiane, and my first time visiting Laos!! I am super excited to be exploring Vientiane. I have always ...',
        thumbnails: { default: { url: 'https://i.ytimg.com/vi/0GDwDqfzWEE/default.jpg', width: 120, height: 90 },
                      medium: { url: 'https://i.ytimg.com/vi/0GDwDqfzWEE/mqdefault.jpg', width: 320,
                                height: 180 },
                      high: { url: 'https://i.ytimg.com/vi/0GDwDqfzWEE/hqdefault.jpg', width: 480,
                              height: 360 } },
        channelTitle: 'keis one',
        liveBroadcastContent: 'none',
        publishTime: '2022-11-11T11:45:00Z'
      }
    }

    final = Video.new(video_data)

    expect(final).to be_a Video
    expect(final.title).to eq(video_data[:snippet][:title])
    expect(final.youtube_video_id).to eq(video_data[:id][:videoId])
    expect(final.instance_variables).to eq(%i[@title @youtube_video_id])
    expect(final.instance_variables).to_not eq(%i[@kind @description])
  end

  it 'will return an empty array if there are no videos in the data' do
    video_data = []
    final = Video.new(video_data)

    expect(final.instance_variables).to eq([])
  end
end
