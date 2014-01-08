module KyanJukebox
  class Rating
    include Base

    attr_accessor :positive_ratings, :rating_class, :negative_ratings,
                  :file, :rating

    def heading
      "Rating"
    end

    def subtitle
      "Current: #{rating}"
    end

    def description
      if positive_ratings.empty? && negative_ratings.empty?
        return "No votes"
      end

      pos = positive_ratings.empty? ? '...' : positive_ratings.join(', ')
      neg = negative_ratings.empty? ? '...' : negative_ratings.join(', ')

      "▲ #{pos} ▼ #{neg}"
    end
  end
end