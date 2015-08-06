$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $.validate();


  $('form#comment-form').submit( function(e) {
    e.preventDefault();//stop browser from what it normally does whiCH is reload the entire page
    $.ajax({
      type: $(this).attr('method'),
      url: $(this).attr('action'),
      data: $(this).serialize(),
      success: function(return_value) {
        console.log(return_value)
        var data = $('form#comment-form > textarea').val();
        $('div#comment-out').append(data);
        $('form#comment-form > textarea').val("");
      },
      fail: function(e) {
        console.log(e);
        alert(e);
      }

    });
  });
});






