require 'rake\clean'

Dir.chdir "project" # Rakefilie should be at top of directory tree (dev folder), this is the only variable that changes

source_files = Rake::FileList["**/*.md", "**/*.markdown"] # file list to be inlcuded
files.exclude("~*") # files to be excluded
files.exclude(/^Notes\//) # folder to be excluded


task :default => :pdf # default task when rake is run without arguments

task :pdf => source_files.ext(".pdf") # printable output with the built files (not the source files)

rule ".pdf" => ".md" do |t|
  sh "pandoc -o #{t.name} #{t.source}"
end

rule ".pdf" => ".markdown" do |t|
  sh "pandoc -o #{t.name} #{t.source}
end

task :mv_target do
  cp '*.md', '/tmp'
  cp '*.markdown', '/tmp', :verbose => true
end

############################################################################################################

# task :clean
#   cp ::FileList

# FileList['data/**/*'].exclude('*.txt')



# directory "/tmp"

# task :copy_some_files do
#   cp 'one_file', 'destination'
#   cp 'another_file', 'destination', :verbose => true
# end

directory '/tmp' # creates a directory task named '/tmp' which will create the '/tmp' directory if it doesn't alrady exist

file '**/*.md' => '/tmp' do
  cp '**/*.md' => '/tmp'
end


file '**/*.markdown' => '/tmp' do
  cp '**/*.markdown' => '/tmp'
end


#PREREQUISITES
