module KyanJukebox
  class Track
    attr_accessor :title, :artist, :album, :added_by,
                  :dbid, :rating, :file, :duration,
                  :artwork_url, :rating_class

    def initialize(data)
      @data = data
      @data.each do |k,v|
        if respond_to?(k.to_sym)
          send("#{k}=", v)
        end
      end
    end

    def heading
      title
    end

    def subtitle
      artist
    end

    def description
      [album, duration].compact.join(' - ')
    end

    def self.build(hsh)
      return nil if hsh.nil?
      new(hsh)
    end
  end
end