module KyanJukebox
  class Playlist < Base
    include Enumerable

    attr_accessor :tracks, :current_track

    def each(&block)
      tracks.each do |track|
        block.call( Track.new(track) )
      end
    end

    def size
      tracks.size
    end

    def limit(amount=5)
      tracks.take(amount)
    end

  end
end