var validating = false;
var isNewMessages = false;

var interval_id;
var focused;
var newTitle;

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
    return text.replace(/(http:\/\/[^\s,]+)/gi, '<a href=\'$1\' target="_blank">$1</a>');
}



function addMessage(message){// поправить функци вставлять сообщения в зависимости от room_id
item = "<li class='new_mes border15px'>"
	item+="<span class='user'>"+message.name+ ": </span>"
	item+="<span class='content'>"+autolink(message.content)+ "</span>"
	item+="<span class='timestamp'>"+message.time+ "</span>"
    item+="</li>"
    if (last_message_id < message.id) {
     last_message_id = message.id }

    newTitle = message.content;
     return item;
}

function new_messages_check(){
  	window.setInterval("get_messages()",7000);

}

function get_messages() {
$.getJSON(window.location.href + '/sendnew',  {//тут надо сделать адрес вида http://hostname/getnewmessages и поправить контроллер
dataType: 'json',
cache: false,
period: period,
last_message_id: last_message_id //передавать json вида [{"room_id":"14", "from":"233", "to": "-1"},{"room_id":"2", "from":"0", "to": "100"}]
//таким образом в зависимости от открытых вкладок будет идти запрос сообщений

})
.done (function(data){
	
html=""

$.each(data, function(key, val) {
    html+=addMessage(val);
    if (focused == false) {
      
      interval_id = setInterval(changeTitle, 1000);}
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
    document.title = oldTitle;
   focused = true;
       
});
$(window).blur(function() {
   focused = false;
       
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

});
