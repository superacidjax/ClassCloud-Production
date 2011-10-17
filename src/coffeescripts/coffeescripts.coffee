window.classCounter = 0
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

@cloneElement = ->
  obj = $("#form1").clone()
  form = obj.appendTo("#clone").html("<div id=\"new_class_" + window.classCounter + "\"><label for=\"class_room_name\">Class name</label><br><input id=\"class_room_name_" + window.classCounter + "\" type=\"text\" name=\"class_room[name][]\"> <a href=\"javascript:removeClass(" + window.classCounter + ")\">Remove</a></div>")
  window.classCounter++

@removeClass = (i) ->
  $("#new_class_" + i).remove()

@addStudent = ->
  obj = $("#form1").clone()
  form = obj.appendTo("#clone").html("<div id=\"new_class_" + window.classCounter + "\">Add Student<input class=\"first_name\" id=\"user_first_name_" + window.classCounter + "\" name=\"user[first_name][]\" placeholder=\"First Name\" size=\"10\" type=\"text\" /><input class=\"last_name\" id=\"user_last_name_" + window.classCounter + "\" name=\"user[last_name][]\" placeholder=\"Last Name\" size=\"10\" type=\"text\" /><input class=\"email\" id=\"user_email_" + window.classCounter + "\" name=\"user[email][]\" placeholder=\"Email\" size=\"10\" type=\"email\" /><a href=\"javascript:removeClass(" + window.classCounter + ")\">Remove</a></div><br>")
  window.classCounter++

@checkTextField = ->
  if $(".first_name").val().length is 0
    alert "first name must not empty "
    false
  else if $(".last_name").val().length is 0
    alert "last name must not empty "
    false
  else if $(".email").val().length is 0
    alert "email must not empty "
    false
  else if $(".class_name").val().length is 0
    alert "class name must not empty "
    false
  else
    true

@mouseIn = (objek) ->
  cbox = objek.cells[0].getElementsByTagName("input")[0]
  objek.style.background = "#E1E3DE"
  objek.style.color = "#000000"
  if cbox.checked is true
    objek.style.background = "#CCC"
    objek.style.color = "#000"

@mouseOut = (objek) ->
  cbox = objek.cells[0].getElementsByTagName("input")[0]
  objek.style.background = "#FFFFFF"
  objek.style.color = "#000000"
  if cbox.checked is true
    objek.style.background = "#CCC"
    objek.style.color = "#000"

@setCheckbox = (e, row) ->
  x = row
  cbox = row.cells[0].getElementsByTagName("input")[0]
  clickedElt = (if window.event then event.srcElement else e.target)
  x.style.color = "#000000"
  unless clickedElt is cbox
    cbox.checked = not (cbox.checked)
    x.style.backgroundColor = (if ("#CCC" is x.style.backgroundColor) then "white" else "#CCC")
    x.style.color = "#FFFFFF"

@uncheckAllSelectedStudents = ->
  totalCB = jQuery(".cb_student_list").length
  i = 0

  while i < totalCB
    jQuery("#" + jQuery(".cb_student_list")[i].id).attr "checked", false
    i++

@uncheckGroupAllowed = ->
  jQuery("#assignment_group_allowed").attr "checked", false

@checkAll = ->
  if $("#Check_ctr").is(":checked") is true
    $(".check_msg").each ->
      @checked = true

    x = 1
    while x <= Number(document.getElementById("ttl").value)
      document.getElementById("chk_id" + x).checked = true
      x++
  else
    x = 1
    while x <= Number(document.getElementById("ttl").value)
      document.getElementById("chk_id" + x).checked = false
      x++

@observerAndStudentListToggle = ->
  if jQuery("#type_student").is(":checked")
    jQuery("#student_list").show()
    jQuery("#observer_list").hide()
  else if jQuery("#type_observer").is(":checked")
    jQuery("#observer_list").show()
    jQuery("#student_list").hide()