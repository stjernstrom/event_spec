require 'fsevents'

class Eventlistener

  attr_accessor :stream
  
  def initialize

    @stream = FSEvents::Stream.watch(:latency => 0) do |events|

    events.each do |event|
      event.modified_files.each do |f|
        filename = f[Dir.pwd.length+1,f.length]

          Mapping.get_instance.mappings.each do |map|
            if filename =~ map[0]
              check_files = (map[1].call( filename, $~ ) * " ")

              system('clear;')
              puts "Executing: #{check_files}\n------------------------------------------------------------\n\n"

              system("script/spec #{check_files} -X -O spec/spec.opts")
            
              puts "\n------------------------------------------------------------\nWaiting since #{Time.now}"
              break
            end
          end

        end
      end
    
    end
  end

  def run_listerner
    @stream.run
  end
  
end