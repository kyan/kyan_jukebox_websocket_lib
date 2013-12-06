module KyanJukebox
  class Base
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
      nil
    end

    def subtitle
      nil
    end

    def description
      nil
    end

    def inspect
      "<#{self.class.name}>"
    end
  end
end