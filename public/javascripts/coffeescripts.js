(function() {
  window.classCounter = 0;
  this.checkField = function() {
    if ($(".check_msg").is(":checked") === false) {
      alert("Please select receiver.");
      return false;
    } else if ($("#message_body").val().length === 0 || $("#message_topic").val().length === 0) {
      alert("message body or message topic is empty");
      return false;
    } else {
      return true;
    }
  };
  this.checkFieldStudentAndObserver = function() {
    if ($("#message_body").val().length === 0 || $("#message_topic").val().length === 0) {
      alert("message body or message topic is empty");
      return false;
    } else {
      return true;
    }
  };
  this.Check = function() {
    if ($("#Check_ctr").is(":checked") === true) {
      return $(".check_msg").each(function() {
         this.checked = true;
      });
    } else {
      return $(".check_msg").each(function() {
         this.checked = false;
      });
    }
  };
  this.cloneElement = function() {
    var form, obj;
    obj = $("#form1").clone();
    form = obj.appendTo("#clone").html("<div id=\"new_class_" + window.classCounter + "\"><label for=\"class_room_name\">Class name</label><br><input id=\"class_room_name_" + window.classCounter + "\" type=\"text\" name=\"class_room[name][]\"> <a href=\"javascript:removeClass(" + window.classCounter + ")\">Remove</a></div>");
    return window.classCounter++;
  };
  this.removeClass = function(i) {
     $("#new_class_" + i).remove();
  };
  this.addStudent = function() {
    var form, obj;
    obj = $("#form1").clone();
    form = obj.appendTo("#clone").html("<div id=\"new_class_" + window.classCounter + "\">Add Student<input class=\"first_name\" id=\"user_first_name_" + window.classCounter + "\" name=\"user[first_name][]\" placeholder=\"First Name\" size=\"10\" type=\"text\" /><input class=\"last_name\" id=\"user_last_name_" + window.classCounter + "\" name=\"user[last_name][]\" placeholder=\"Last Name\" size=\"10\" type=\"text\" /><input class=\"email\" id=\"user_email_" + window.classCounter + "\" name=\"user[email][]\" placeholder=\"Email\" size=\"10\" type=\"email\" /><a href=\"javascript:removeClass(" + window.classCounter + ")\">Remove</a></div><br>");
    return window.classCounter++;
  };
  this.checkTextField = function() {
    if ($(".first_name").val().length === 0) {
      alert("first name must not empty ");
      return false;
    } else if ($(".last_name").val().length === 0) {
      alert("last name must not empty ");
      return false;
    } else if ($(".email").val().length === 0) {
      alert("email must not empty ");
      return false;
    } else if ($(".class_name").val().length === 0) {
      alert("class name must not empty ");
      return false;
    } else {
      return true;
    }
  };
  this.mouseIn = function(objek) {
    var cbox;
    cbox = objek.cells[0].getElementsByTagName("input")[0];
    objek.style.background = "#E1E3DE";
    objek.style.color = "#000000";
    if (cbox.checked === true) {
      objek.style.background = "#CCC";
      return objek.style.color = "#000";
    }
  };
  this.mouseOut = function(objek) {
    var cbox;
    cbox = objek.cells[0].getElementsByTagName("input")[0];
    objek.style.background = "#FFFFFF";
    objek.style.color = "#000000";
    if (cbox.checked === true) {
      objek.style.background = "#CCC";
      return objek.style.color = "#000";
    }
  };
  this.setCheckbox = function(e, row) {
    var cbox, clickedElt, x;
    x = row;
    cbox = row.cells[0].getElementsByTagName("input")[0];
    clickedElt = (window.event ? event.srcElement : e.target);
    x.style.color = "#000000";
    if (clickedElt !== cbox) {
      cbox.checked = !cbox.checked;
      x.style.backgroundColor = ("#CCC" === x.style.backgroundColor ? "white" : "#CCC");
      return x.style.color = "#FFFFFF";
    }
  };
  this.uncheckAllSelectedStudents = function() {
    var i, totalCB, _results;
    totalCB = jQuery(".cb_student_list").length;
    i = 0;
    _results = [];
    while (i < totalCB) {
      jQuery("#" + jQuery(".cb_student_list")[i].id).attr("checked", false);
      _results.push(i++);
    }
    return _results;
  };
  this.uncheckGroupAllowed = function() {
     jQuery("#assignment_group_allowed").attr("checked", false);
  };
  this.checkAll = function() {
    var x, _results, _results2;
    if ($("#Check_ctr").is(":checked") === true) {
      $(".check_msg").each(function() {
         this.checked = true;
      });
      x = 1;
      _results = [];
      while (x <= Number(document.getElementById("ttl").value)) {
        document.getElementById("chk_id" + x).checked = true;
        _results.push(x++);
      }
      return _results;
    } else {
      x = 1;
      _results2 = [];
      while (x <= Number(document.getElementById("ttl").value)) {
        document.getElementById("chk_id" + x).checked = false;
        _results2.push(x++);
      }
      return _results2;
    }
  };
  this.observerAndStudentListToggle = function() {
    if (jQuery("#type_student").is(":checked")) {
      jQuery("#student_list").show();
       jQuery("#observer_list").hide();
    } else if (jQuery("#type_observer").is(":checked")) {
      jQuery("#observer_list").show();
       jQuery("#student_list").hide();
    }
  };
}).call(this);
