module KyanJukebox
  class Playlist < Array
    include Base

    attr_accessor :tracks, :current_track

    def initialize(data)
      super data
      replace tracks.map {|track| Track.new(track)} unless tracks.nil?
    end

    def upcoming_tracks(_track=nil)
      _index = current_track_index(_track)
      _index.nil? ? [] : self[_index+1...self.size]
    end

    def next_track
      self[current_track_index+1]
    end

    def previous_track
      self[current_track_index-1]
    end

    private

    def current_track_index(_current=nil)
      _track = _current.nil? ? current_track : _current
      index { |track| track.file == _track }
    end
  end
end
