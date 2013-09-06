class Remoteprogram

# Ruby program will give the result of minimum number of clicks necessary to get 
#  through all the channels that Users would like to watch.

  

# creating the 4 arrays 
   # 1) list of channels available
   # 2) list of need to view
   # 3) positions for all the channels available
   # 4) positions for all the channels need to view

  def initialize(start_stop,blocked,sequence)

   #create the array for start and end channel limit
   @start_stop = start_stop.split(/ /).map { |s| s.to_i }  

   #create the array for list of channel available 
   @ch_withblock = @start_stop[0].upto(@start_stop[1]).map { |s| s.to_i }

   #create the array for blocked channels
   @blocked = blocked.split(/ /).map { |s| s.to_i }  

   #removing the count element from blocked list
   @count_blocked = @blocked.shift 
   @ch_blocked = @blocked 

   #ignore the blocked channels
   @ch_available = @ch_withblock - @ch_blocked

   #create the array of channels need to view
   @sequence = sequence.split(/ /).map { |s| s.to_i }  

   # removing the count element from channel list
   @count_sequence = @sequence.shift 
   @ch_viewlist = @sequence
   
   #positions for all channel list
   @ch_available_pos = Hash[@ch_available.map.with_index.to_a] 

   #positions for the view channel list
   @ch_viewlist_pos = Hash[@ch_viewlist.map.with_index.to_a] 
 end


# for each element in need to view array we will find shorest number of clicks based on:
#   1) pressing the remote button up
#   2) pressing the remote button down
#   3) pressing the remote button previous channel and then up
#   4) pressing the remote button previous channel and then down
def result

 ch_clicks = 0
 @current_postion = 0
 condition_clicks = 0
 count = 0

 # loop starts for the need to view channel list 
 @ch_viewlist.each do |requiredch|

# assuming first channel will do by clicking the channel number
if count == 0 and @ch_viewlist[count] == requiredch
 ch_clicks = ch_clicks + requiredch.to_s.length.to_i
 @pre_channel = @ch_available[@current_postion]
 @current_postion = @ch_available_pos[requiredch]

# if current channel position and required postion are same
elsif @ch_available_pos[requiredch] == @current_postion 
 ch_clicks = ch_clicks
 @pre_channel = @ch_available[@current_postion]
 @current_postion = @ch_available_pos[requiredch]

# if channel digit is 1 then click is 1
elsif requiredch.to_s.length.to_i == 1 
 ch_clicks = ch_clicks+1
 @pre_channel = @ch_available[@current_postion]
 @current_postion = @ch_available_pos[requiredch]

else  # channel digit is > 1
 ch_digit_length = requiredch.to_s.length
 condition_clicks = 0


            # pressing up button in remote 
            #compare the positions of current and required channel                      
            if @ch_available_pos[requiredch] < @current_postion 

             clicks_forward = @ch_available_pos.size + (@ch_available_pos[requiredch] - @current_postion)
          elsif @ch_available_pos[requiredch] > @current_postion

             clicks_forward = @ch_available_pos[requiredch] - @current_postion

          end

            # pressing down button in remote  
            #compare the positions of current and required channel  
            if @ch_available_pos[requiredch] > @current_postion 

             clicks_backward = @ch_available_pos.size - (@ch_available_pos[requiredch] - @current_postion)
          elsif @ch_available_pos[requiredch] < @current_postion

             clicks_backward = @current_postion - @ch_available_pos[requiredch]
          end


           # pressing back button in remote 
           # if previous channel not available then no need for checking clicks
           if @pre_channel!=nil 

             if @ch_available_pos[@pre_channel] == @ch_available_pos[requiredch]
              clicks_previous = 1

           else

                # pressing up button after clicking previous button            
                if @ch_available_pos[requiredch] < @ch_available_pos[@pre_channel]

                   clicks_forwardinback = @ch_available_pos.size + (@ch_available_pos[requiredch] - @ch_available_pos[@pre_channel])
                elsif @ch_available_pos[requiredch] > @ch_available_pos[@pre_channel]

                   clicks_forwardinback = @ch_available_pos[requiredch] - @ch_available_pos[@pre_channel]

                end

                # pressing down button after clicking previous button  
                if @ch_available_pos[requiredch] > @ch_available_pos[@pre_channel]

                 clicks_backwardinback = @ch_available_pos.size - (@ch_available_pos[requiredch] - @ch_available_pos[@pre_channel])
              elsif @ch_available_pos[requiredch] < @ch_available_pos[@pre_channel]

                 clicks_backwardinback = @ch_available_pos[@pre_channel] - @ch_available_pos[requiredch]
              end


                # condition for selecting shorest inside previous button

                if clicks_forwardinback < clicks_backwardinback 
                  clicks_previous = clicks_forwardinback + 1
               else
                  clicks_previous = clicks_backwardinback + 1
               end

            end
         end

        # condition for selecting shorest click based on up ,down and back button clicks

        if (clicks_previous!=nil  and (clicks_forward < clicks_backward and clicks_forward < clicks_previous)) or (clicks_previous==nil and clicks_forward < clicks_backward)
         clickscount = clicks_forward
      elsif (clicks_previous!=nil  and (clicks_backward < clicks_forward and clicks_backward < clicks_previous)) or (clicks_previous==nil and clicks_backward < clicks_forward)
         clickscount = clicks_backward
      elsif clicks_previous!=nil
         clickscount = clicks_previous
      end

        # if the number of clicks are more than the numebr of digits in channel 
        # then take count of digit in the channel as click count

      if clickscount < requiredch.to_s.length
         totalclicks = clickscount
      else
         totalclicks = requiredch.to_s.length
      end

      # adding the clicks with total clicks
      ch_clicks = ch_clicks+totalclicks 

      # assigning the current postion of the channel
      @current_postion = @ch_available_pos[requiredch] 

      # assigning the previous channel position
      @pre_channel = @ch_available[@current_postion] 



     end
     count = count+1

  end
  return ch_clicks
end

end


