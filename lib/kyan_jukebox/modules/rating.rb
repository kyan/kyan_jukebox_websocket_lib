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
      if positive_ratings && positive_ratings.empty? && negative_ratings && negative_ratings.empty?
        return "No votes"
      end

      [p_ratings, n_ratings].join(' ')
    end

    def p_ratings
      if positive_ratings && positive_ratings.any?
        "▲ #{positive_ratings.join(', ')}"
      else
        ""
      end
    end

    def n_ratings
      if negative_ratings && negative_ratings.any?
        "▼ #{negative_ratings.join(', ')}"
      else
        ""
      end
    end
  end
end