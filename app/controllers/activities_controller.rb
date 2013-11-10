class ActivitiesController < ApplicationController


def active_users
	
	create_or_update_time current_user.id, params[:room_id]
	
	@activity = Activity.where("room_id = ?", params[:room_id])
		respond_to do |format|
   		   format.json { 
       	   render :json => @activity.map { 
        	  |activity| 
         	   {
         	   :name => "#{view_context.link_to(activity.name, user_path(activity.user_id))}" ,
         	   :time => activity.time
         	  	}
     			}
     		}
 end


end


end
