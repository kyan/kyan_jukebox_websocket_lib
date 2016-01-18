module KyanJukebox
  class Track
    include Base

    attr_accessor :title, :artist, :album, :added_by,
                  :dbid, :rating, :file, :duration,
                  :artwork_url, :rating_class, :eta

    def heading
      title
    end

    def subtitle
      artist
    end

    def description
      album
    end
  end
end
