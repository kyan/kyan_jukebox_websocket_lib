module KyanJukebox
  class Notify

    attr_accessor :json_parser, :notify_only

    VALID_KEYS = [
      :state, :time, :rating, :track_added, :track, :playlist, :volume
    ]

    def initialize(keys=[])
      @active_keys    = keys
      @data           = {}
      @whats_changed  = []
      @json_parser    = nil
      @notify_only    = [:track]
    end

    def update!(payload)
      refresh_dataset! if parse_payload(payload)
    end

    def notifications
      @whats_changed.map {|k| send(k) if notify_only.include?(k) }.compact
    end

    def method_missing(meth, *args, &block)
      if @active_keys.include?(meth.to_sym)
        KyanJukebox.const_get(meth.to_s.capitalize).new(fetch(meth.to_sym))
      else
        super
      end
    end

    def refresh_dataset!
      @whats_changed.clear

      VALID_KEYS.each do |key|
        if @json && @json[key.to_s]
          @data[key] = @json[key.to_s]
          if @data[key] && @active_keys.index(key)
            @whats_changed << key
          end
        end
      end
    end

    private

    def fetch(key)
      @data[key]
    end

    def parse_payload(str)
      if json_parser.nil?
        raise "You need to set a JSON parser. e.g json_parser = 'BW::JSON'"
      end

      @json = json_parser.parse(str)
    end
  end
end