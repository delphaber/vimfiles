task :default => [:init_submodules, :command_t, :link]

task :init_submodules do
  sh "git submodule update --init"
end

task :update do
  sh "git pull origin master"
  sh "git submodule foreach git pull"
end

task :link do
  %w[vimrc gvimrc].each do |script|
    dotfile = File.join(ENV['HOME'], ".#{script}")
    if File.exist? dotfile
      warn "~/.#{script} already exists"
    else
      ln_s File.join('.vim', script), dotfile
    end
  end
end

task :command_t do
  puts "Compiling Command-T plugin..."
  Dir.chdir "bundle/command-t/ruby/command-t" do
    if File.exists?("/usr/bin/ruby1.8") # prefer 1.8 on *.deb systems
      sh "/usr/bin/ruby1.8 extconf.rb"
    elsif File.exists?("/usr/bin/ruby") # prefer system rubies
      sh "/usr/bin/ruby extconf.rb"
    elsif `rvm > /dev/null 2>&1` && $?.exitstatus == 0
      sh "rvm system ruby extconf.rb"
    elsif `rbenv > /dev/null 2>&1` && $?.exitstatus == 0
      sh "RBENV_VERSION=system ruby extconf.rb"
    end
    sh "make clean && make"
  end
end
