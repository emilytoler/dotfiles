require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :default => [:install]
task :install => [:submodules, :files]

task :submodules do
  puts 'updating submodules ...'
  system('git submodule init') and system('git submodule update')
  puts '... done updating submodules.'
end

task :files do
  puts 'updating files ...'
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README.md LICENSE SETUP.md mac-terminals].include? file
    next if file =~ /~$/

    if File.exist?(File.join(ENV['HOME'], ".#{o(file)}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{o(file)}")
        puts "identical ~/.#{o(file)}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{o(file)}? [ynaq] (return skips) "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{o(file)}"
        end
      end
    else
      link_file(file)
    end
  end
  puts '... done updating files.'
end

def o(file)
  file.sub('.erb', '')
end

def replace_file(file)
  if File.exists?("#{ENV['HOME']}/.#{o(file)}")
    old_file_date = File.mtime(o(file)).strftime('%Y-%m-%d')
    system %Q{mv -f "$HOME/.#{o(file)}" "$HOME/.#{o(file)}-#{old_file_date}"}
  end
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{o(file)}"
    File.open(File.join(ENV['HOME'], ".#{o(file)}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end
