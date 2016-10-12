# A Full Stack Ruby on Rails App Demonstration

### About
This app is a sampling of classic video games. Clicking on the name of the game will popup a detail view with a like button and possibly an image. You will be able to like the game by clicking the 'like' link.
See the demo here: http://gonotes.net:8000

### Technical details
The app creates a database (SQLite), imports game data into it, displays the data with jQuery and SASS, makes AJAX calls to populate the popup, and relays 'likes' back to the database making sure a user (actually IP) cannot like a game twice. There are unit and functional tests for all models and controllers.

### Setup Instructions
This is best run on a Linux environment with Imagemagick available, but should work fine on a Mac.
See the https://github.com/minimagick/minimagick#requirements if you need MiniMagick setup help.

Run the following commands from project root to setup the database. Substitute "my_environment" with `development` or `production` (Note that game photos are loaded before game data import).

    RAILS_ENV=my_environment rake db:migrate:reset  # start fresh    
    RAILS_ENV=my_environment rake app:csv_import

### Production Setup
bundle
RAILS_ENV=production rake db:migrate:reset
RAILS_ENV=production rake app:csv_import
rake assets:clobber # start fresh
rake assets:precompile

start the app in production with:
 `sudo RAILS_ENV=production SECRET_KEY_BASE=mysecretkeyReplacewithyours RAILS_SERVE_STATIC_FILES=true rails s -b 0.0.0.0 -p 80`