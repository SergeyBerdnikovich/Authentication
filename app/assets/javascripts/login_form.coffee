$ ->
  $('form').on 'ajax:complete', (xhr, status) ->
    data = status.responseText
    if data == 'Error'
      $("#alert").remove()
      $(".form-horizontal").before("<p id = 'alert' class = 'text-error'>Invalid data</p>")
    else
      $("#alert").remove()
      $(".form-horizontal").before("<p id = 'alert' class = 'text-error'>Enter code: "+data+"</p>")
      $(".form-horizontal").replaceWith("<form class='form-horizontal' method='post' data-remote='true' action='/second_step' accept-charset='UTF-8'><p><label for='email_or_login'>Enter Code</label><br><input  type='text' name='code'></p><input class='btn' type='submit' value='Activate' name='commit'></form>")