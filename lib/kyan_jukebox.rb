fs = [
  'kyan_jukebox/modules/base.rb',
  'kyan_jukebox/modules/track.rb',
  'kyan_jukebox/modules/playlist.rb',
  'kyan_jukebox/modules/rating.rb',
  'kyan_jukebox/notify.rb',
]

if defined?(Motion::Project::Config)
  Motion::Project::App.setup do |app|
    fs.each do |file|
      f = File.join(File.dirname(__FILE__), file)
      app.files.unshift(f)
    end
  end
else
  fs.each do |file|
    f = File.join(File.dirname(__FILE__), file)
    require f
  end
end