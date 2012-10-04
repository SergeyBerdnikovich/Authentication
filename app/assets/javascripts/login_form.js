$(function() {
  return $('form').on('ajax:complete', function(xhr, status) {
    var data;
    data = status.responseText;
    if (data === 'Error') {
      $("#alert").remove();
      return $(".form-horizontal").before("<p id = 'alert' class = 'text-error'>Invalid data</p>");
    }
  });
});
