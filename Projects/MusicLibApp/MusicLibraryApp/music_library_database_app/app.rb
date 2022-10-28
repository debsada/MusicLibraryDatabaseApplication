# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get "/albums" do
    album_repo = AlbumRepository.new
    @albums = album_repo.all

    # response = albums.map do |record|
    #   record.title + ", "

    return erb(:albums)
    
    # return response
  end

  get "/artists" do 
    artist_repo = ArtistRepository.new
    @artists = artist_repo.all

    return erb(:artists)
  end

  post "/albums" do 
    special_chars = ('!'..'?').to_a

    special_chars.each do |char|
      if params[:title].include?char
        return erb(:new_album)
      end
    end

    album_repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]
    album_repo.create(new_album)
    
    return erb(:album_added)
  end

  get "/artists" do 
    artist_repo = ArtistRepository.new
    artists = artist_repo.all

    response = artists.map do |record|
      record.name + ", "
    end
  end

  post "/artists" do
    artist_repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]
    artist_repo.create(new_artist)

    return erb(:artist_added)
  end

  get "/albums/new" do
    return erb(:new_album)
  end

  get "/albums/:id" do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
   
  end

  get "/artists/new" do
    return erb(:new_artist)
  end

  get "/artists/:id" do 
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])

    return erb(:artist)
  end
end