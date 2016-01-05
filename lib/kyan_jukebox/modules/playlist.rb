module KyanJukebox
  class Playlist < Array
    include Base

    attr_accessor :tracks, :current_track

    def initialize(data)
      super data
      replace tracks.map {|track| Track.new(track)} unless tracks.nil?
    end

    def upcoming_tracks
      current_track_index.nil? ? [] : self[current_track_index...-1]
    end

    def next_track
      self[current_track_index+1]
    end

    def previous_track
      self[current_track_index-1]
    end

    private

    def current_track_index
      @current_track_index ||= index { |track| track.file == current_track }
    end
  end
end
