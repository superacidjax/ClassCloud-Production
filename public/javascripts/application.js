// // Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

window.classCounter = 0;

function Check(){
    if($("#Check_ctr").is(':checked') == true)
        $('.check_msg').each(function(){
            this.checked = true;
        });
 
    else
        $('.check_msg').each(function(){
            this.checked = false;
        });

}
function mouseIn(objek){
    var cbox = objek.cells[0].getElementsByTagName('input')[0];
    objek.style.background = "#E1E3DE";
    objek.style.color = "#000000";
    if(cbox.checked == true){
        objek.style.background = "#CCC";
        objek.style.color = "#000";
    }
}

function mouseOut(objek) {
    var cbox = objek.cells[0].getElementsByTagName('input')[0];
    objek.style.background = "#FFFFFF";
    objek.style.color = "#000000";
    if(cbox.checked == true){
        objek.style.background = "#CCC";
        objek.style.color = "#000";
    }
}

function setCheckbox(e, row){
    var x = row;
    var cbox = row.cells[0].getElementsByTagName('input')[0];
    var clickedElt = window.event? event.srcElement: e.target;
    x.style.color = "#000000";
    if (clickedElt != cbox){
        cbox.checked = !(cbox.checked);
        x.style.backgroundColor = ('#CCC' == x.style.backgroundColor) ? 'white' : '#CCC';
        x.style.color = "#FFFFFF";
    }
}

function uncheckAllSelectedStudents() {
    var totalCB = jQuery(".cb_student_list").length;
    for(var i = 0; i < totalCB; i++)
        jQuery("#"+jQuery(".cb_student_list")[i].id).attr("checked", false);
}

function uncheckGroupAllowed()  {
    jQuery("#assignment_group_allowed").attr("checked", false);
}

function checkAll(){
    if($("#Check_ctr").is(':checked') == true){
        $('.check_msg').each(function(){
            this.checked = true;
        });
        for(x=1; x <=Number(document.getElementById("ttl").value); x++){
            document.getElementById('chk_id' + x).checked = true;
        }
    }else{

        for(x=1; x <=Number(document.getElementById("ttl").value); x++){
            document.getElementById('chk_id' + x).checked = false;
        }
    }
}

function observerAndStudentListToggle() {
    if(jQuery("#type_student").is(":checked"))  {
        jQuery("#student_list").show();
        jQuery("#observer_list").hide();
    }
    else if(jQuery("#type_observer").is(":checked"))  {
        jQuery("#observer_list").show();
        jQuery("#student_list").hide();
    }
}


function checkField(){
    if($(".check_msg").is(':checked') == false){
        alert ('Please select receiver.');
        return false;
    }
    else if($("#message_body").val().length==0 || $("#message_topic").val().length==0) {
        alert('message body or message topic is empty');
        return false;
    }
    else
    {
        return true;
    }
    
}

function cloneElement(){
    //    obj = $("#form1").clone()
    //    obj.appendTo("#clone");
    obj = $("#form1").clone();
    var form = obj.appendTo("#clone").html('<div id="new_class_'+ window.classCounter +'"><label for="class_room_name">Class name</label><br><input id="class_room_name_'+ window.classCounter +'" type="text" name="class_room[name][]"> <a href="javascript:removeClass('+ window.classCounter +')">Remove</a></div>');
    window.classCounter++;
}

function removeClass(i){
    $("#new_class_"+i).remove();
}

function addStudent(){
    obj = $("#form1").clone();
    var form = obj.appendTo("#clone").html('<div id="form1">Add Student<input class="first_name" id="user_first_name_" name="user[first_name][]" placeholder="First Name" size="10" type="text" /><input class="last_name" id="user_last_name_" name="user[last_name][]" placeholder="Last Name" size="10" type="text" /><input class="email" id="user_email_" name="user[email][]" placeholder="Email" size="10" type="email" /><br><br></div>');

}

function checkTextField(){
    if($(".first_name").val().length==0){
        alert('first name must not empty ');
        return false;
    }
    else if ($(".last_name").val().length==0){
        alert('last name must not empty ');
        return false;
    }
    else if ($(".email").val().length==0){
        alert('email must not empty ');
        return false;
    }
    else{
        return true;
    }
}

function removeElement(){
$("#clone").remove()
}
