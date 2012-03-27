# remove files
run "rm README.rdoc"
run "rm public/index.html"
run "rm app/assets/images/rails.png"
run "cp config/database.yml config/database.yml.example"

# install gems
run "rm Gemfile"
file 'Gemfile', File.read("#{File.dirname(rails_template)}/Gemfile")
run "bundle install"

# generate rspec
generate "rspec:install"
append_file '.rspec', <<-CODE
--format documentation
CODE

rake "db:create:all"

# application.rb settings
# donot automatic generate helper file.
environment "
    config.generators do |g|
      g.test_framework :rspec, :fixture => false, :view_specs => false
      g.helper false
    end
"
gsub_file 'config/application.rb', /# config.active_record.whitelist_attributes = true/, 'config.active_record.whitelist_attributes = true'
# gsub_file 'config/application.rb', /# config.i18n.default_locale = :de/, 'config.i18n.default_locale = "zh-CN"'
# gsub_file 'config/application.rb', /# config.time_zone = 'Central Time (US & Canada)'/, 'config.time_zone = "Beijing"'


inject_into_file 'app/assets/javascripts/application.js', before: '//= require_tree .' do
  <<-JS
//= require jquery
//= require jquery_ujs
  JS
end

# .gitignore
append_file '.gitignore', <<-CODE
config/database.yml
Thumbs.db
.DS_Store
tmp/*
coverage/*
Session.vim
*.swp
CODE

# git commit
git :init
git :add => '.'
git :add => 'tmp/.gitkeep -f'
git :add => 'log/.gitkeep -f'
git :commit => "-a -m 'initial commit'"
