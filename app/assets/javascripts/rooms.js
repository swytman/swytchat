var validating = false;
var isNewMessages = false;

var interval_id;
var newTitle;
var oldTitle;

function changeTitle(){

if (document.title==newTitle)
  {document.title = oldTitle}
else
{document.title = newTitle}

}



function isLocalStorageAvailable() {
    try {
        return 'localStorage' in window && window['localStorage'] !== null;
    } catch (e) {
        return false;
    }
}


function autolink(text) {
    return text.replace(/(https?:\/\/[^\s,]+)/gi,'<a href=\'$1\' target="_blank">$1</a>');
}



function addMessage(message){
item = "<li id='mes"+message.id+"' class='new_mes border15px'>"
	item+="<span class='user'>"+message.name+ ": </span>"
	item+="<span class='content'>"+autolink(message.content)+ "</span>"
	item+="<span class='timestamp'>"+message.time+ "</span>"
    item+="</li>"
    if (last_message_id < message.id) {
     last_message_id = message.id }
//enable popover... no need yet
//$('#btn_day').popover({ title: 'Look! A bird!', content: 'jaja', html:true })

    newTitle = message.content;
     return item;
}

function addUser(user, data){
  
  if (data.status == 'true'){
item = "<li class='in_room'>"+ data.name+"</li>";
        
       } 
       else {
item = "<li>"+ data.name+"</li>";

       }

 return item;
}


function new_messages_check(){
  	window.setInterval("get_messages()",10000);

}

function users_check(){
    window.setInterval("get_users()",30000);

}

function get_users(){
  $.getJSON(window.location.origin + '/activities/active_users',  {
dataType: 'json',
cache: false,
active: focused,
room_id: room_id
})
.done (function(data){
  
html=""

$.each(data, function(key, val) {
    html+=addUser(key,val);
  });

$('.users').html(html);
});

}

function get_messages() {
$.getJSON(window.location.href + '/sendnew',  {
cache: false,
period: period,
last_message_id: last_message_id,
room_id: room_id
})
.done (function(data){
	
html=""

$.each(data, function(key, val) {
    html+=addMessage(val);
    if (focused == false) {
      
      clearInterval(interval_id);
      interval_id = setInterval(changeTitle, 500);}
});

$('.messages').prepend(html);

});
}

$(document).ready(function(){
 
  $('#new_message')
    .bind("ajax:success", function(data, status, xhr) {
       get_messages() ;
       validating = false;
      $('#btn_send').removeAttr('disabled');
       $('#message_content').focus();
       $('#message_content').val('');
    })
    .bind("ajax:error", function(xhr, status, error) {
      validating = false;
      $('#btn_send').removeAttr('disabled');
        //add error handler

    })

     .submit(function(){
      $('.new_mes').removeClass('new_mes')
      if(validating) return false;
      
       
            var isFormValid = true;
               if ($("#message_content").val().length == 0) //Проверка что текст сообщения не пустой
               {
                 isFormValid = false;
               }

               if (isFormValid == true) {
                 $('#btn_send').attr('disabled', 'disabled');
                 validating = true;

                    
               }

               return isFormValid;
        });


$(window).focus(function() {
  clearInterval(interval_id);
    if (oldTitle) {document.title = oldTitle;}

   focused = true;
   get_users();
   get_messages();
       
});
$(window).blur(function() {
   focused = false;
   get_users();
       
});



   $('.btn-mini').click(this,function() {
  
   var id = $( this ).attr('id');
   if (id == 'btn_all') { period = 4};
   if (id == 'btn_month') { period = 3};
   if (id == 'btn_week') { period = 2};
   if (id == 'btn_day') { period = 1};
   
   last_message_id=0;
   get_messages();
   $('.messages').empty();
   
  });

$('#chpass').click(function() {
    var $this = $(this);
    // $this will contain a reference to the checkbox   
    if ($this.is(':checked')) {
        $('#div_chpass').fadeIn("fast")
    } else {
      $('#div_chpass').fadeOut("fast")
    }
});


});
