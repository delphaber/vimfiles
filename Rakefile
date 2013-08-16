task :default => [:init_submodules, :link]

task :init_submodules do
  sh "git submodule update --init"
end

task :update do
  sh "git pull origin master"
  sh "git submodule foreach 'git checkout master && git pull'"
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
