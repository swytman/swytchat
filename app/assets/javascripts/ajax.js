<<<<<<< HEAD
var validating = false;



var period = 1;

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

=======
jQuery(function($) {
2   // create a convenient toggleLoading function
3   //var toggleLoading = function() { $("#loading").toggle() };
4  
5   //$("#tool-form")
6     //.bind("ajax:beforeSend",  toggleLoading)
7     //.bind("ajax:complete", toggleLoading)
8     //.bind("ajax:success", function(data, status, xhr) {
9      // $("#response").html(status);
10      //});
11  });
>>>>>>> 3b677240a1af763080ca0ffd663ceab21046c9fc

/*1. 
add function which disable submit button while ajax working

http://stackoverflow.com/questions/4448955/loading-gif-image-while-jquery-ajax-is-running
http://stackoverflow.com/questions/2198476/jquery-best-way-to-block-any-other-processes-while-waiting-for-ajax-completion


2.Выделение в тексте ссылок!
<!DOCTYPE HTML PUBLIC  "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<script>
window.onload=function() {
    document.getElementById('s').innerHTML=document.getElementById('x').innerHTML.replace(/(http:\/\/[^\s,]+)/gi, '<a href=\'$1\'>$1</a>');
}
</script>
</head>
<body>
<div id="x">test http://ya.ru, link http://mail.ru/?id=1&num=2 end</div>
<div id="s"></div>
</body>
</html>

3. Открыть ссылку в новой строке
http://stackoverflow.com/questions/12133894/open-link-in-new-tab-with-link-to

<%= link_to image_tag("facebook.png", :class => "facebook_icon", :alt => "Facebook"), "http://www.facebook.com/mypage", :target => "_blank" %>

*/

<<<<<<< HEAD
function addMessage(message){
item = "<li class='new_mes'>"
=======
function addMessage(message){// поправить функци вставлять сообщения в зависимости от room_id
item = "<li class='new_mes border15px'>"
>>>>>>> 3b677240a1af763080ca0ffd663ceab21046c9fc
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
$.getJSON(window.location.href + '/sendnew',  {//тут надо сделать адрес вида http://hostname/getnewmessages и поправить контроллер
dataType: 'json',
cache: false,
<<<<<<< HEAD
last_message_id: last_message_id,
period: period
=======
last_message_id: last_message_id //передавать json вида [{"room_id":"14", "from":"233", "to": "-1"},{"room_id":"2", "from":"0", "to": "100"}]
//таким образом в зависимости от открытых вкладок будет идти запрос сообщений
>>>>>>> 3b677240a1af763080ca0ffd663ceab21046c9fc
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


   $('.btn-mini').click(this,function() {
  
   var id = $( this ).attr('id');
   if (id == 'btn_all') { period = 4};
   if (id == 'btn_month') { period = 3};
   if (id == 'btn_week') { period = 2};
   if (id == 'btn_day') { period = 1};
   
   last_message_id=0;
   get_messages();
   $('.messages').empty();
   //    $( this ).button();
  });
  


})



