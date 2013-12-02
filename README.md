# KyanJukebox

A RubyGem to handle messages from the Kyan jukebox Websocket server

## Installation

Add this line to your application's Gemfile:

    gem 'kyan_jukebox'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kyan_jukebox

## Usage

<pre>
jukebox = KyanJukebox::Notify.new([:track])
jukebox.json_parser = JSON
jukebox.notifications
[...]
</pre>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
