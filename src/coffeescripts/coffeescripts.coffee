@checkField = ->
  if $(".check_msg").is(":checked") == false
    alert "Please select receiver."
    false
  else if $("#message_body").val().length == 0 or $("#message_topic").val().length == 0
    alert "message body or message topic is empty"
    false
  else
    true

@checkFieldStudentAndObserver = ->
  if $("#message_body").val().length == 0 or $("#message_topic").val().length == 0
    alert "message body or message topic is empty"
    false
  else
    true

@Check = ->
  if $("#Check_ctr").is(":checked") == true
    $(".check_msg").each ->
      @checked = true
  else
    $(".check_msg").each ->
      @checked = false