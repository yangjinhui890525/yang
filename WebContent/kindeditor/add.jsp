<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 	<script type="text/javascript" charset="utf-8" src="kindeditor.js"></script>
		<script type="text/javascript" charset="utf-8" src="jquery-1.3.1.js"></script> -->
<%
request.setCharacterEncoding("UTF-8");
String htmlData = request.getParameter("content") != null ? request.getParameter("content") : "";
%>
<link rel="stylesheet" href="themes/default/default.css" />
	<link rel="stylesheet" href="plugins/code/prettify.css" />
	<script charset="utf-8" src="kindeditor.js"></script>
	<script charset="utf-8" src="lang/zh_CN.js"></script>
	<script charset="utf-8" src="plugins/code/prettify.js"></script>
	<script>
		var editor1=null;
		KindEditor.ready(function(K) {
			 editor1 = K.create('textarea[name="content"]', {
				cssPath : 'plugins/code/prettify.css',
				uploadJson : 'jsp/upload_json.jsp',
				fileManagerJson : 'jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['form1'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['form1'].submit();
					});
				}
			});
			prettyPrint();
		});
		function getValue()
		{
			alert(editor1.html());
		}
	</script>

<form name="form1" method="post" action="add2.jsp">
类型：
<input type="radio" id="catalog" name="catalog" value="news" CHECKED>news
<input type="radio" id="catalog" name="catalog" value="iactive-marketing">iactive-marketing
<input type="radio" id="catalog" name="catalog" value="liveuc-marketing">liveuc-marketing
<input type="radio" id="catalog" name="catalog" value="imm-marketing">imm-marketing
<br><br>

标题： <input type="text" id="title" name="title" style="width:800px">
<br><br>

内容： <textarea id="content" name="content" style="width:800px;height:500px"></textarea>
<br><br>

<input type="submit" style="width:100px" name="OK" value="提交">
<input type="reset" style="width:100px" name="reset" value="清空">
<input type="button" style="width:100px" name="return" value="返回" onclick="window.location='./'">

</form>
<script type="text/javascript">

/*     var editor = null;
    KindEditor.ready(function () {
        editor = KindEditor.create("#content");
    }); */
	function getValue()
	{
		alert(editor.html());
	}
</script>
