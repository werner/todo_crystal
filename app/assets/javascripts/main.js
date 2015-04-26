$(document).ready(function(){
  jQuery(".del").click(function(event){
    event.preventDefault();
    var confirmBox = confirm("Are you sure?");
    if (confirmBox) {
      var form = jQuery('<form>', {'action': event.currentTarget.pathname, 'method': 'POST'});
      form.submit();
    }
  });

  jQuery(".checkTask").click(function(event){
    $form = $("<form action=/tasks/" + $(this).val() + "/check method='POST'></form>");
    if ($(this).is(':checked')) {
      $form.append("<input type='hidden' name='done' value='1'>");
    } else {
      $form.append("<input type='hidden' name='done' value='0'>");
    }
    $('body').append($form);
    $form.submit();
  });
});
