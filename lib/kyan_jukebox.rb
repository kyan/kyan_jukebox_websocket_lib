afile = File.join(File.dirname(__FILE__), 'kyan_jukebox/notify.rb')
files = File.join(File.dirname(__FILE__), 'kyan_jukebox/modules/*.rb')

if defined?(Motion::Project::Config)
  Motion::Project::App.setup do |app|
    Dir.glob(files).each do |file|
      app.files.unshift(file)
    end
    app.files.unshift(afile)
  end
else
  Dir.glob(files).each do |file|
    require file
    require afile
  end
end