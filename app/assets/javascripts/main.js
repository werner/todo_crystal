$(document).ready(function(){
  jQuery(".del").click(function(event){
    event.preventDefault();
    var confirmBox = confirm("Are you sure?");
    if (confirmBox) {
      var form = jQuery('<form>', {'action': event.currentTarget.pathname, 'method': 'POST'});
      form.submit();
    }
  });
});
