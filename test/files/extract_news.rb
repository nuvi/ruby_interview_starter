require 'fileutils'


# I am leaving my comments in so that you can see my thought process.  I have never
#   done this type of file transfer before in ruby using these words, so I first made 
#   a tester file to see if I could puts the data to make sure I was getting my tester. 
#   I generally code using step by step validation.


def extract
  
  #file = "hello_tester.rb"
  
  file = "news.zip"
  get_file = File.open(file, "r"){ |file| file.read }

  if get_file  
     #puts get_file
     
     #new_dir = "should_make_a_new_file"
     new_dir = "extract"
    
     Dir.mkdir(new_dir) unless File.exists?(new_dir)
     
      
  end
end

extract()
