require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ["lib", "specs"]
  t.warning = false
  t.verbose = false
  t.test_files = FileList['specs/*_spec.rb']
  puts "Running TestTask"
end

task default: :test do # Running before the default task, run the test task. TestTask first then default task. If command line is "test task" instead of "rake", only the test task is run. 
    puts "Running my Rakefile"
end
