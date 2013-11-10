include RoomsHelper

class ClearOfflineUsers
 @queue = :cleaner

 def self.perform
  	Activity.find_each do |a|
	Resque.logger.info a.destroy if (a.time <=> Time.now - 1.minute) == -1
end
			
   
 end



end
