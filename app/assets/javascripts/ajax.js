var validating = false;
function autolink(text) {
    return text.replace(/(http:\/\/[^\s,]+)/gi, '<a href=\'$1\' target="_blank">$1</a>');
}



function addMessage(message){
item = "<li class='new_mes'>"
	item+="<span class='user'>"+message.name+ ": </span>"
	item+="<span class='content'>"+autolink(message.content)+ "</span>"
	item+="<span class='timestamp'>"+message.time+ "</span>"
    item+="</li>"
    if (last_message_id < message.id) {
     last_message_id = message.id }
     return item;
}

function new_messages_check(){
	window.setInterval("get_messages()",7000);

}


function get_messages() {
$.getJSON(window.location.href + '/sendnew',  {
dataType: 'json',
cache: false,
last_message_id: last_message_id
})
.done (function(data){
	
//json = jQuery.parseJSON(data)
//$('.new_mes').removeClass('new_mes')
html=""

$.each(data, function(key, val) {
    html+=addMessage(val)
});

$('.messages').prepend(html);

//new_messages_check();


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


})



