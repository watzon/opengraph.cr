require "http/client"
require "crystagiri"
require "./opengraph/version"
require "./opengraph/object"

# TODO: Write documentation for `Opengraph`
module OpenGraph
  extend self

  # Fetch Open Graph data from the specified `url`. Makes an
  # HTTP GET request and returns an `OpenGraph::Object`
  # or nil if the URL was not found.
  def self.from_url(url)
    res = HTTP::Client.get(url)

    # Check for redirects
    if (300..303).includes?(res.status_code) && res.headers["Location"]?
      location = res.headers["Location"].to_s
      return self.from_url(location)
    end

    self.parse(res.body)
  end

  # Parse raw `html` either from a string or an `XML::Node`
  # and return an `OpenGraph::Object`.
  def self.parse(html, strict = true)
    doc = Crystagiri::HTML.new(html)
    page = OpenGraph::Object.new
    doc.css("meta") do |m|
      attributes = m.node.attributes
      if attributes["property"]? && attributes["property"].to_s.match(/["']og:(.+)['"]/i)
        prop = $1.gsub("-", "_")
        content = attributes["content"].to_s
        if value = content.match(/["'](.+)['"]/i)
          page[prop] = value[1].strip
        end
      end
    end
    page
  end
end
