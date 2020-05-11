# Spotify on Youtube API

API to handle request incoming from the [Spotify on Youtube Chrome Extension](https://github.com/8geonirt/spotify-on-youtube-extension) project.

## Prerequisites
* [Ruby](https://www.ruby-lang.org/) v2.6.3+

## Getting Started

1. Clone the repository.
2. Go to the repository folder.
3. Run the command `bundle install`
4. Run `rails db:setup`
5. Run `rails s` to start Rails server
6. Start adding/fixing code

## API Keys
* Copy the `.env.sample` file and rename it to `.env`.

The following environment variables are required:
```
SPOTIFY_CLIENT_ID=abcccccxccxfdds
SPOTIFY_CLIENT_SECRET=231321321
REDIRECT_URI=http://localhost:3000/authorized
LYRICS_API_URL=https://orion.apiseeds.com/api/music/lyric/
LYRICS_API_TOKEN=321321321
```
* The Spotify Client ID and Spotify Client Secret can be created/obtained from the [Spotify Developers Dashboard](https://developer.spotify.com/dashboard/)
- Also de REDIRECT_URI can be set in that dashboard.

* The lyrics API token can be created/obtained on [API Seeds](https://orion.apiseeds.com/)

## Using the API
This is a complement for the [Spotify on Youtube Chrome Extension]([https://github.com/8geonirt/spotify-on-youtube-extension](https://github.com/8geonirt/spotify-on-youtube-extension)) project.

Please refer to the README for more references in how you can target this project to start using the Spotify API correctly.

## Built with
* Ruby on Rails
