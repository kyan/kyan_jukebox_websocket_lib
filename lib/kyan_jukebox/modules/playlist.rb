module KyanJukebox
  class Playlist < Array
    include Base

    attr_accessor :tracks, :current_track

    def initialize(data)
      super data
      replace tracks.map {|track| Track.new(track)} unless tracks.nil?
    end

  end
end