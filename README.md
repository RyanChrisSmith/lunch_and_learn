# README

### Set up
* Api Keys
  - [REST Countries API](https://restcountries.com/#api-endpoints-v3-all) - no key needed
  - [Edamam Recipe API](https://developer.edamam.com/edamam-recipe-api) - no key needed
  - Follow directions at [Google Youtube API](https://developers.google.com/youtube/v3/getting-started) to set up your developers page and get an api key, this project used [Serch:list](https://developers.google.com/youtube/v3/docs/search/list) end points with `part = snippet` and `type = video` in the query params of the endpoint
  - [Unsplash](https://unsplash.com/documentation#search-photos) was used to get images, you will need to set up an account with them as well to get an api key. Follow the directions on their website.
  - [Places API](https://apidocs.geoapify.com/docs/places/#categories) was used as well. Follow directions on their website to get an api key

* Getting started
  - Versions
    - Ruby 2.7.4
    - Rails 5.2.8
  - Clone this repo
  - `bundle install`
  - `bundle exec figaro install`
    - put all keys in `config/application.yml`
      - Rest countries no key needed
      - Edamam keys you will need both the id and key given named `recipe_id` and `recipe_key`
      - Google keys will need to be named `google_key`
      - Unsplash key will need to be named `access_key`
      - Places key will need to be name `places_key`
  - `rails db:{create,migrate,seed}`
  - `rails s`



### Learning Goals
* Expose an API that aggregates data from multiple external APIs
  - exposed `"https://restcountries.com/v3.1/all?fields=name"` endpoint
  - exposed `"https://api.unsplash.com/search/photos"` endpoint
  - exposed `"https://youtube.googleapis.com/youtube/v3/search?"` endpoint
    - combined all of these endpoints to then build a response for the FE to get a single response from the `"http:localhost:3000/api/v1/learning_resources?country="` endpoint
      - response included the country either searched for or a random country if there was not a query
      - a video related to country queried / random
      - 10 images related to the country queried / random

* Expose an API that requires an authentication token
  - exposed `"https://api.unsplash.com/search/photos"` endpoint using the `access_key`

* Expose an API for CRUD functionality
  - exposed `"http:localhost:3000/api/v1/favorites"` to be able to delete `favorites` if needed

* Determine completion criteria based on the needs of other developers
  - update functionality seems overkill on the `favorites` as the recipes are either `favorited` or `not`, so update was not utilized for an endpoint
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).
  - `webmock` was used via `vcr`, stubbing was used in tests that required random countries

### Happy path endpoints
- Example happy paths to get recipes for a country
  - `GET /api/v1/recipes?country=thailand`
  - `GET /api/v1/recipes?country=`
    - will return a random country's recipes
  - `GET /api/v1/recipes?country=" "`
    - will return an empty array
- Example happy paths to get learning resources for a certain country
  - `GET /api/v1/learning_resources?country=laos`
  - `GET /api/v1/learning_resources?country=`
    - will return resources for a random country
  - `GET /api/v1/learning_resources?country=" "`
    - will return an empty array
- Examples of CRUD functionality around users and favorite recipes
  - `POST /api/v1/users`
    - passing `{"name": "Athena Dao", "email": "athenadao@bestgirlever.com", "password": "password", "password_confirmation": "password"}` in the body will register a user
  - `POST /api/v1/sessions`
    - passing `{"email": "athenadao@bestgirlever.com", "password": "password"}` in the body will sign an existing user in
  - `POST /api/v1/favorites`
    - passing `{"api_key": <API_KEY_OF_EXISTING_USER>,"country":"thailand","recipe_link": "https://www.tastingtable.com/.....","recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"}` will create a new favorite for the user
  - `GET /api/v1/favorites`
    - passing `{"api_key": <API_KEY_OF_EXISTING_USER>}` will get a list of all of the favorites of that user.
    - If the user does not have favorites, it will return an empty array