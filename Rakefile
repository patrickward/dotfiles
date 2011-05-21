# Rakefile for installing config files to user's home directory
# Original credit goes to Ryan Bates at http://github.com/ryanb/dotfiles/
# 
# Patrick Ward: added ssh in "next if" check. Need to manually edit link for config file there. 

########################################################################
###
### Patrick Ward's Dotfiles/Vim setup 
### Based on the work of many others. See README.rdoc for credits.
###
########################################################################

require 'rake'
require 'erb'

task :default do
  puts "This Rakefile installs updates the configuration directory and associated bundles."
  puts # blank line
  puts "Usage: $ rake update:dotfiles"
end 

namespace :update do
  
  desc "update/install dot files into the current user's home directory"
  task :dotfiles do
    replace_all = false
    Dir['*'].each do |file|
      next if %w[Rakefile README.rdoc LICENSE ssh bin].include? file
    
      if File.exist?(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"))
        if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
          puts "identical ~/.#{file.sub('.erb', '')}"
        elsif replace_all
          replace_file(file)
        else
          print "overwrite ~/.#{file.sub('.erb', '')}? [ynaq] "
          case $stdin.gets.chomp
          when 'a'
            replace_all = true
            replace_file(file)
          when 'y'
            replace_file(file)
          when 'q'
            exit
          else
            puts "skipping ~/.#{file.sub('.erb', '')}"
          end
        end
      else
        link_file(file)
      end
    end
  end # task :install

end # namespace :update

def replace_file(file)
  system %Q{rm "$HOME/.#{file.sub('.erb', '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking: ln -s #{ENV['PWD']}/#{file} #{ENV['HOME']}/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end
