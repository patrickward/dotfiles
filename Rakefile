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
require 'pathname'

task :default do
  puts "This Rakefile installs updates the configuration directory and associated bundles."
  puts # blank line
  puts "Usage: $ rake (update:dotfiles | update:bundles)"
end 

namespace :update do
  
  VIMBUNDLES = {
    # plugins
    :rails         => "git://github.com/tpope/vim-rails.git",
    :surround      => "git://github.com/tpope/vim-surround.git",
    :snipmate      => "git://github.com/msanders/snipmate.vim.git", 

    # syntax definitions
    :syntax_git       => "git://github.com/tpope/vim-git.git",
    :syntax_fugitive  => "git://github.com/tpope/vim-fugitive.git", 
    :syntax_markdown  => "git://github.com/tpope/vim-fugitive.git",
    :syntax_rdoc      => "git://github.com/hallison/vim-rdoc.git",
  }
  
  desc "update/install dot files into the current user's home directory"
  task :dotfiles do
    replace_all = false
    Dir['*'].each do |file|
      next if %w[Rakefile README.rdoc LICENSE ssh].include? file
    
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
  
  desc "update any vim bundles defined in the Rakefile"
  task :bundles do
    
    bundle_home = Pathname.new( ENV['HOME'] ) + '.vim' + 'bundle'
    mkdir_p bundle_home
    
    VIMBUNDLES.sort_by {|k,v| k.to_s }.each do |bundle, location|
      target_path = bundle_home + bundle.to_s
      
      puts "*" * 72
      puts "*** Installing #{bundle} to #{target_path} from #{location}"
      puts # blank line 
      
      rm_rf target_path
      
      case location.match( /^(.*?):/ )[1]
      when 'git'
        sh "git clone #{location} #{target_path} > /dev/null"
        rm_rf target_path + '.git'
      when 'http'
        mkdir_p target_path
        sh "cd #{target_path} && curl -s '#{location}' | tar zx -"
      end 
      
      docdir = target_path + 'doc'
      if docdir.exist?
        puts "doc dir exists; tagging" 
        sh "vim -u NONE -esX -c 'helptags #{docdir}' -c quit"
      end 
      
      puts # blank line
    end 
    
  end # task :bundles

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