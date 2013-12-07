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
      pos = positive_ratings.empty? ? '...' : positive_ratings.join(', ')
      neg = negative_ratings.empty? ? '...' : negative_ratings.join(', ')

      "Up: #{pos} - Down: #{neg}"
    end
  end
end