files = File.join(File.dirname(__FILE__), 'kyan_jukebox/*.rb')

if defined?(Motion::Project::Config)
  Motion::Project::App.setup do |app|
    Dir.glob(files).each do |file|
      app.files.unshift(file)
    end
  end
else
  Dir.glob(files).each do |file|
    require file
  end
end