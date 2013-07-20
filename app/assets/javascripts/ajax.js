



function new_messages_check(){
setTimeout("get_messages()",5000);
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
	item = "<li>"
	item+="<span class='user'>"+val.name+ ": </span>"
	item+="<span class='content'>"+val.content+ "</span>"
	item+="<span class='timestamp'>"+val.time+ "</span>"
    item+="</li>"
    if (last_message_id < val.id) {
     last_message_id = val.id }
    
    html+=item
    
});

$('.messages').prepend(html);

new_messages_check();


});
}

