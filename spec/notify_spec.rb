require 'spec_helper'
require 'json'

describe "Jukebox Notifications" do

  def fetch(data)
    open("spec/fixtures/#{data}.json").read
  end

  before do
    @notify = Notify.new([:track, :rating, :playlist, :time])
    @notify.json_parser = JSON
  end

  context "The Jukebox" do
    before do
      @notify.update!( fetch('all') )
    end

    it "has notifications" do
      expect(@notify.notifications.size).to eql(1)
      expect(@notify.notifications.first).to be_kind_of(Track)
    end

    it "should handle track updates" do
      expect(@notify.track.title).to eql("Ernest Borgnine")
      @notify.update!( fetch('track') )
      expect(@notify.track.title).to eql("Waterloo")
      expect(@notify.whats_changed).to eql([:track])
    end
  end

  context "A Track" do
    before do
      @notify.update!( fetch('all') )
    end

    it "has a track" do
      expect(@notify.track.title).to eql("Ernest Borgnine")
    end

    it "has an artist" do
      expect(@notify.track.artist).to eql("John Grant")
    end

    it "has an added_by" do
      expect(@notify.track.added_by).to eql("Gav")
    end

    it "has a file" do
      expect(@notify.track.file).to eql("gavin/John Grant/Pale Green Ghosts/09 Ernest Borgnine.mp3")
    end

    it "has a rating" do
      expect(@notify.track.rating).to eql(1)
    end

    it "has a dbid" do
      expect(@notify.track.dbid).to eql(29404)
    end

    it "has a duration" do
      expect(@notify.track.duration).to eql('04:53')
    end

    it "has an album" do
      expect(@notify.track.album).to eql('Pale Green Ghosts')
    end

    it "has artwork_url" do
      expect(@notify.track.artwork_url).to eql('http://ecx.images-amazon.com/images/I/51OTk9vdQML.jpg')
    end

    it "has rating_class" do
      expect(@notify.track.rating_class).to eql('positive_1')
    end
  end

  context "A Rating" do
    before do
      @notify.update!( fetch('all') )
    end

    it "has a positive_ratings" do
      expect(@notify.rating.positive_ratings).to eql(["Gav"])
      expect(@notify.rating.p_ratings).to eql("▲ Gav")
    end

    it "has an rating_class" do
      expect(@notify.rating.rating_class).to eql("positive_1")
    end

    it "has an negative_ratings" do
      expect(@notify.rating.negative_ratings).to eql([])
      expect(@notify.rating.n_ratings).to eql("")
    end

    it "has an file" do
      expect(@notify.rating.file).to eql("gavin/John Grant/Pale Green Ghosts/09 Ernest Borgnine.mp3")
    end

    it "has an rating" do
      expect(@notify.rating.rating).to eql(1)
    end

    it "has a description" do
      expect(@notify.rating.description).to eql("▲ Gav")
    end

    it "should have changed items" do
      expect(@notify.whats_changed).to eql([:time, :rating, :track, :playlist])
    end

    it "should have changed ratings" do
      expect(@notify.last_change?(:rating)).to be_truthy
    end

    it "should not have changed volume" do
      expect(@notify.last_change?(:volume)).to be_falsey
    end

    it "should have time" do
      expect(@notify.time).to eql('40')
    end

  end

  context "A Tracklist" do
    before do
      @notify.update!( fetch('playlist') )
    end

    it "should have tracks" do
      expect(@notify.playlist.size).to eql(18)
      expect(@notify.playlist.any?).to be_truthy
      expect(@notify.playlist.take(3).size).to eql(3)
    end

    it "should have a first track" do
      track = @notify.playlist.first

      expect(track.title).to eql("Dear Sons and Daughters of Hungry Ghosts")
      expect(track.artist).to eql("Wolf Parade")
      expect(track.artwork_url).to eql("http://ecx.images-amazon.com/images/I/51JKRGpkHYL.jpg")
    end

    it "should have a current track" do
      expect(@notify.playlist.current_track).to eql('gavin/02006 Mixtapes/20060201/2006 020112 Band of Horses - The Funeral.mp3')
    end

    context "upcoming tracks" do
      it "should return upcoming tracks when there are some" do
        expect(@notify.playlist.upcoming_tracks.size).to eql(13)
      end
    end

    it "should return the next track" do
      expect(@notify.playlist.next_track.title).to eql('The Great Salt Lake')
    end

    it "should return the previous track" do
      expect(@notify.playlist.previous_track.title).to eql("I'll Believe In Anything You'll Believe In Anything")
    end

    it "should have changed ratings" do
      expect(@notify.whats_changed).to eql([:time, :playlist])
    end

    it "should have time" do
      expect(@notify.time).to eql('114')
    end
  end

  context "A Time" do
    before do
      @notify.update!( fetch('all') )
    end

    it "should have time" do
      expect(@notify.time).to eql('40')
    end
  end
end
