# /lib/tasks/mytask.rake
namespace :mytask do
  task :default => 'mytask:full_run'

  desc "run all tasks in proper order"
  task :full_run => [:example_task_one, :example_task_two] do
    puts "All tasks ran and completed at #{Time.now}"
  end

  desc "example task without arguments"
  task :example_task_one => :environment do
    # task code goes here
    puts "Example Task One completed"
  end

  desc "example task with arguments"

  task :example_task_two, [:arg1, :arg2] => :environment do |t, args|
    # if no arguments, display docs
    if args.count == 0
      puts ''
      puts "rake mytask:example_task[arg1,arg2]"
      puts "arg1: description of first argument"
      puts "arg2: description of second argument"
      puts ''
      puts "example:"
      puts "rake mytask:example_task[123,'456']"
      puts ''
    else
      # task code goes here
      puts "Running task with arg1: #{args.arg1}, and arg2: #{args.arg2}"
      puts "Example Task Two completed"
    end

  end
end
