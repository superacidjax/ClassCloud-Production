(function() {
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
        return this.checked = true;
      });
    } else {
      return $(".check_msg").each(function() {
        return this.checked = false;
      });
    }
  };
}).call(this);
