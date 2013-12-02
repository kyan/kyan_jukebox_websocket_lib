module KyanJukebox
  class Notify

    attr_accessor :json_parser

    VALID_KEYS = [
      :state, :time, :rating, :track_added, :track, :playlist, :volume
    ]

    def initialize(keys=[])
      @active_keys    = keys
      @data           = {}
      @whats_changed  = []
      @json_parser    = nil
    end

    def update!(payload)
      parse_payload(payload)
      refresh_dataset!
    end

    def track
      @track = Track.build(fetch(:track))
    end

    def rating
      @rating = Rating.build(fetch(:rating))
    end

    def notifications
      @whats_changed.map {|k| send(k)}.compact
    end

    private

    def fetch(key)
      @data[key]
    end

    def refresh_dataset!
      @whats_changed.clear

      VALID_KEYS.each do |key|
        if @json && @json[key.to_s]
          if @data[key] = @json[key.to_s]
            @whats_changed << key if @active_keys.index(key)
          end
        end
      end
    end

    def parse_payload(str)
      if json_parser.nil?
        raise "You need to set a JSON parser. e.g json_parser = 'BW::JSON'"
      end

      @json = json_parser.parse(str)
    rescue
      # ignore for now
    end
  end
end