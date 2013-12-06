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
      parse_payload(payload)
      refresh_dataset!
    end

    def notifications
      @whats_changed.map {|k| send(k) if notify_only.include?(k) }.compact
    end

    def method_missing(meth, *args, &block)
      if @active_keys.include?(meth.to_sym)
        Object.const_get(meth.to_s.capitalize).new(fetch(meth.to_sym))
      else
        super
      end
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

      begin
        @json = json_parser.parse(str)
      rescue => detail
        print detail.backtrace.join("\n")
      end
    end
  end
end