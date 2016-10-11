# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :app do
  require 'pry'

  desc 'Start a pry console'
  task console: :environment do
    Pry.start
  end

  desc 'Load game images'
  task load_photos: :environment do
    puts 'Creating thumbnails...'
    original_path = 'app/assets/images/games'
    format = 'png'
    thumbnail_dir = 'thumbs'
    Dir.entries("#{File.expand_path(original_path)}").each do |fname|
      file = File.join(original_path, fname)
      next unless File.file?(file)
      basename = snakecase(File.basename(fname, '.*')) # without ext
      outfile = File.join(original_path, thumbnail_dir, "#{basename}.#{format}")
      image = MiniMagick::Image.open(file)
      image.resize '200x200'
      image.format format
      image.write outfile
      puts "#{file} --> #{outfile}"
      # Load Database
      if Photo.where(url: file).any?
        puts "#{file} already in database"
        next
      else
        Photo.create(url: file, thumb: File.basename(outfile)) # basename with ext
      end
    end
  end

  desc 'Import from CSV'
  task csv_import: [:environment, :load_photos ] do
    if Game.any?
      puts 'There is already data in the database. Perhaps a db:reset is needed'
    else
      puts 'Importing game data from csv...'
      require 'csv'
      CSV.foreach('games.csv', headers: true) do |row|
        active = %w(1 y yes true).include? row['is_active'].downcase

        g = Game.create(
            name:  row['name'], year: row['year'], manufacturer: row['manufacturer'],
            notes: row['notes'], is_active: active)

        # Associate with photo
        thumb_name = snakecase(g.name)
        thumb_name = 'burgertime' if g.name == 'BurgerTime' # Exception for 'BurgerTime'
        thumb_name += '.png'
        p = Photo.where(thumb: thumb_name).first
        if p
          g.photo = p
          g.save
        end

        puts row['name']
      end
    end
  end

  def snakecase(str)
    str.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr('-', '_').tr("'",'').
        strip.gsub(/\s/, '_').
        gsub(/__+/, '_').
        downcase
  end
end
