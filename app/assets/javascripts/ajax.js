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

function addMessage(message){
item = "<li class='new_mes border15px'>"
	item+="<span class='user'>"+message.name+ ": </span>"
	item+="<span class='content'>"+message.content+ "</span>"
	item+="<span class='timestamp'>"+message.time+ "</span>"
    item+="</li>"
    if (last_message_id < message.id) {
     last_message_id = message.id }
     return item;
}

function new_messages_check(){
	window.setInterval("get_messages()",5000);

}


function get_messages() {
$.getJSON(window.location.href + '/sendnew',  {
dataType: 'json',
cache: false,
last_message_id: last_message_id
})
.done (function(data){
	
//json = jQuery.parseJSON(data)

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
       $('#message_content').focus();
       $('#message_content').focus();
      $('#message_content').val('');
    })
    .bind("ajax:error", function(xhr, status, error) {

        //add error handler

    });
})



