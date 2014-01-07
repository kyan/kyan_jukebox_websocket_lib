require 'spec_helper'
require 'json'

describe "Jukebox Notifications" do

  def fetch(data)
    open("spec/fixtures/#{data}.json").read
  end

  before do
    @notify = Notify.new([:track, :rating, :playlist])
    @notify.json_parser = JSON
  end

  context "The Jukebox" do
    before do
      @notify.update!( fetch('all') )
    end

    it "has notifications" do
      @notify.notifications.size.should == 1
      @notify.notifications.first.should be_kind_of(Track)
    end

    it "should handle track updates" do
      @notify.track.title.should == "Ernest Borgnine"
      @notify.update!( fetch('track') )
      @notify.track.title.should == "Waterloo"
      @notify.whats_changed.should == [:track]
    end
  end

  context "A Track" do
    before do
      @notify.update!( fetch('all') )
    end

    it "has a track" do
      @notify.track.title.should == "Ernest Borgnine"
    end

    it "has an artist" do
      @notify.track.artist.should == "John Grant"
    end

    it "has an added_by" do
      @notify.track.added_by.should == "Gav"
    end

    it "has a file" do
      @notify.track.file.should == "gavin/John Grant/Pale Green Ghosts/09 Ernest Borgnine.mp3"
    end

    it "has a rating" do
      @notify.track.rating.should == 1
    end

    it "has a dbid" do
      @notify.track.dbid.should == 29404
    end

    it "has a duration" do
      @notify.track.duration.should == '04:53'
    end

    it "has an album" do
      @notify.track.album.should == 'Pale Green Ghosts'
    end

    it "has artwork_url" do
      @notify.track.artwork_url.should == 'http://ecx.images-amazon.com/images/I/51OTk9vdQML.jpg'
    end

    it "has rating_class" do
      @notify.track.rating_class.should == 'positive_1'
    end
  end

  context "A Rating" do
    before do
      @notify.update!( fetch('all') )
    end

    it "has a positive_ratings" do
      @notify.rating.positive_ratings.should == ["Gav"]
    end

    it "has an rating_class" do
      @notify.rating.rating_class.should == "positive_1"
    end

    it "has an negative_ratings" do
      @notify.rating.negative_ratings.should == []
    end

    it "has an file" do
      @notify.rating.file.should == "gavin/John Grant/Pale Green Ghosts/09 Ernest Borgnine.mp3"
    end

    it "has an rating" do
      @notify.rating.rating.should == 1
    end

    it "should have changed ratings" do
      @notify.whats_changed.should == [:rating, :track, :playlist]
    end
  end

  context "A Tracklist" do
    before do
      @notify.update!( fetch('playlist') )
    end

    it "should have tracks" do
      @notify.playlist.size.should == 18
      @notify.playlist.any?.should be_true
      @notify.playlist.take(3).size.should == 3
    end

    it "should have a first track" do
      track = @notify.playlist.first

      track.title.should == "Dear Sons and Daughters of Hungry Ghosts"
      track.artist.should == "Wolf Parade"
      track.artwork_url.should == "http://ecx.images-amazon.com/images/I/51JKRGpkHYL.jpg"
    end

    it "should have a current track" do
      @notify.playlist.current_track.should == 'gavin/02006 Mixtapes/20060201/2006 020112 Band of Horses - The Funeral.mp3'
    end

    it "should have changed ratings" do
      @notify.whats_changed.should == [:playlist]
    end
  end
end