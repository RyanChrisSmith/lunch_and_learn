require 'rails_helper'

RSpec.describe 'Video PORO' do
  it 'can take only the info needed from the API return' do
    video_data = {
      :kind=>"youtube#searchListResponse",
      :etag=>"BRt3qu6MwlwHho8U5iieT-lz12I",
      :nextPageToken=>"CAEQAA",
      :regionCode=>"US",
      :pageInfo=>{:totalResults=>1000000, :resultsPerPage=>1},
      :items=>
        [{:kind=>"youtube#searchResult",
          :etag=>"VJ8vh9PGCjSq-hQ8BFgrfvuzpZw",
          :id=>{
            :kind=>"youtube#video", :videoId=>"0GDwDqfzWEE"},
          :snippet=>{
            :publishedAt=>"2022-11-11T11:45:00Z",
            :channelId=>"UCO5IhWS7_CIU1HoAkffBzcg",
            :title=>"Vientiane, Laos - First Impressions - Not what I expected!! 🇱🇦",
            :description=>
              "Today is my first Day in Vientiane, and my first time visiting Laos!! I am super excited to be exploring Vientiane. I have always ...",
            :thumbnails=>
              {:default=>{:url=>"https://i.ytimg.com/vi/0GDwDqfzWEE/default.jpg", :width=>120, :height=>90},
              :medium=>{:url=>"https://i.ytimg.com/vi/0GDwDqfzWEE/mqdefault.jpg", :width=>320, :height=>180},
              :high=>{:url=>"https://i.ytimg.com/vi/0GDwDqfzWEE/hqdefault.jpg", :width=>480, :height=>360}},
            :channelTitle=>"keis one",
            :liveBroadcastContent=>"none",
            :publishTime=>"2022-11-11T11:45:00Z"}}]}

      final = Video.new(video_data)

      expect(final.title).to eq(video_data[:items][0][:snippet][:title])
      expect(final.youtube_video_id).to eq(video_data[:items][0][:id][:videoId])
  end
end