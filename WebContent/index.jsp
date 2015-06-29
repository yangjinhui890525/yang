<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script src="js/jquery1.6.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="jquery-ui-1.11.2.custom/jquery-ui.min.css">
<script type="text/javascript" src="jquery-ui-1.11.2.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src="jquery-ui-1.11.2.custom/jquery-ui.js"></script>
</head>
<body>
<div id="dialog" title="test">
	<p>这是一个采用默认样式的对话框</p>
</div>
 

 <div id="dialog-form" class="ui-widget ui-widget-content ui-corner-all" title="用户登录"> 

 <p id="login_tip"></p> 

 <form id="login-form"> 
 <fieldset> 
 username:<input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" /> 
 password:<input type="password" name="password" id="password" value="" class="text ui-widget-content ui-corner-all" /> 
 </fieldset> 
 </form> 
 </div>  
<input type="button" value="打开" onclick="open_dialog();"/>
<input type="text" name="date" id="date" />
</body>
<script type="text/javascript">
$("#date" ).datepicker();
$("#dialog-form").dialog(
	{
		autoOpen:false, 
		 modal:true,
		 backgroundColor: '#000',
		show:{
		effect:"blind",
		duration:"1000"
		},
		hide:{effect:"explode",
			dutation:"1000"}
	
	}
	); 
	
function open_dialog(){
    $("#dialog-form").dialog("open");
}


</script>

</html>