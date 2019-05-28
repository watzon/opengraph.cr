# opengraph.cr

Crystal wrapper for the [Open Graph](http://ogp.me) protocol, allowing you to parse Open Graph meta tags and extract valuable information.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     opengraph:
       github: watzon/opengraph.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "opengraph"

og = OpenGraph.from_url("css-tricks.com")
# og = OpenGraph.parse("<!-- RAW HTML -->")

puts og.website?
# => true

puts og["title"]?
# => "CSS-Tricks"

puts og["image"]?
# => "https://css-tricks.com/wp-content/uploads/2014/03/css-tricks-star.png"
```

## Contributing

1. Fork it (<https://github.com/watzon/opengraph/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chris Watson](https://github.com/watzon) - creator and maintainer
