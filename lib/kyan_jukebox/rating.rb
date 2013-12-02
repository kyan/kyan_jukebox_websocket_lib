module KyanJukebox
  class Rating
    attr_accessor :positive_ratings, :rating_class, :negative_ratings,
                  :file, :rating

    def initialize(data)
      return nil if data.nil?

      @data = data
      @data.each do |k,v|
        if respond_to?(k.to_sym)
          send("#{k}=", v)
        end
      end
    end

    def heading
      "Rating"
    end

    def subtitle
      "Current: #{rating}"
    end

    def description
      pos = positive_ratings.empty? ? '...' : positive_ratings.join(', ')
      neg = negative_ratings.empty? ? '...' : negative_ratings.join(', ')

      "Up: #{pos} - Down: #{neg}"
    end

    def valid?
      self
    end

    def self.build(hsh)
      return nil if hsh.nil?
      new(hsh)
    end
  end
end