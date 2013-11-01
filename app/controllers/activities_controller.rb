class ActivitiesController < ApplicationController


def active_users
	
	create_or_update_time current_user.id, params[:id]
	
	#@@slogger.info ("Activities::active_users request 
	 	#room_id=#{params[:id]}, by user_id=#{current_user.id}")
	@activity = Activity.where("room_id = ?", params[:id])
		respond_to do |format|
   		   format.json { 
       	   render :json => @activity.map { 
        	  |activity| 
         	   {
         	   :name => activity.name,
         	   :time => activity.time
         	  	}
     			}
     		}
 end


end


end
