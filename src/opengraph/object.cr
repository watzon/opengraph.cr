module OpenGraph
  class Object < Hash(String, String)
    MANDATORY_ATTRIBUTES = %w(title type image url)

    TYPES = {
      "activity"     => %w(activity sport),
      "business"     => %w(bar company cafe hotel restaurant),
      "group"        => %w(cause sports_league sports_team),
      "organization" => %w(band government non_profit school university),
      "person"       => %w(actor athlete author director musician politician public_figure),
      "place"        => %w(city country landmark state_province),
      "product"      => %w(album book drink food game movie product song tv_show),
      "website"      => %w(blog website),
    }

    def initialize
      super
    end

    def type
      self["type"]?
    end

    def schema
      TYPES.each_pair do |schema, types|
        return schema if types.includes?(self.type.to_s)
      end
      nil
    end

    {% for type in TYPES.values.reduce { |acc, i| acc + i } %}
      def {{type.id}}?
        self.type == {{type}}
      rescue
        nil
      end

      def {{type.id}}
        self.type == {{type}}
      end
    {% end %}

    {% for scheme in TYPES.keys %}
      def {{scheme.id}}?
        self.type == {{scheme}} || TYPES[{{scheme}}].includes?(self.type)
      end

      def {{scheme.id}}
        self.type == {{scheme}} || TYPES[{{scheme}}].includes?(self.type)
      rescue
        nil
      end
    {% end %}

    def valid?
      MANDATORY_ATTRIBUTES.each { |a| return false unless self[a]? }
      true
    end
  end
end
