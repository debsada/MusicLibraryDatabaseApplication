require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "returns a 200 response and title and year for all albums" do 
      response = get("/albums")

      expect(response.status).to eq(200)
      expect(response.body).to include("Title: Surfer Rosa")
      expect(response.body).to include("Released: 1988")
      expect(response.body).to include('<a href="/albums/2" >Surfer Rosa</a><br />')
      expect(response.body).to include('<a href="/albums/3" >Waterloo</a><br />')
      expect(response.body).to include('<a href="/albums/4" >Super Trouper</a><br />')
      expect(response.body).to include('<a href="/albums/5" >Bossanova</a><br />')
      expect(response.body).to include('<a href="/albums/6" >Lover</a><br />')
    end
  end

  context "POST /albums" do
    it "returns a 200 response and new entry" do 
      response = post("/albums", title: "Voyage", release_year: "2022", artist_id: 2)
      expect(response.status).to eq(200)
      # expect(get("/albums").body).to eq ("Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring, Voyage, ")
    end
  end

  context "GET /artists" do
    it "returns a 200 response and list of artists" do 
      response = get("/artists")
      expect(response.status).to eq(200)
      # expect(response.body).to eq("Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, ")
    end
  end

  context "POST /artists" do 
    it "returns a 200 response and creates a new artist entry" do
      response = post("/artists", name: "Wild nothing", genre: "Indie")
      expect(response.status).to eq(200)
      # expect(get("/artists").body).to eq("Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild nothing, ")
    end
  end

  context "GET /albums/:id" do 
    it "returns a 200 response and album for id 1" do
      response = get("/albums/2")
      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Surfer Rosa</h1>")
      expect(response.body).to include("Release year: 1988")
      expect(response.body).to include("Artist: Pixies")
    end
  end

  context "GET /artists/:id" do
    it "returns a 200 response and details for a single artist" do
      response = get("/artists/2")
      expect(response.status).to eq(200)
      expect(response.body).to include("Artist: ABBA")
      expect(response.body).to include("Genre: Pop")
    end
  end

  context "GET /artists" do 
    it "returns the 200 response and a list of the artists' links" do
    response = get("/artists")
    expect(response.status).to eq(200)
    expect(response.body).to include("<a href='/artists/2'>ABBA</a>")
    end
  end

  context "GET /albums/new" do 
    it "returns the form page" do 
      response = get("/albums/new")

      expect(response.status).to eq(200)
      expect(response.body).to include('<form action="/albums" method="POST">')
    end
  end

  context "GET /artists/new" do 
    it "returns the form page" do 
      response = get("/artists/new")

      expect(response.status).to eq(200)
      expect(response.body).to include('<form action="/artists" method="POST">')
      expect(response.body).to include('input type="text" name="name"')
      expect(response.body).to include('input type="text" name="genre"')
    end

    # it "adds new entry and returns a success page"

  end

  #add tests for album_added and artist_added 
  #add test for cyber security

end
