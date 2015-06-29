<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
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

<%!
	public static String date2String(Date d, boolean bDateTime)
	{
		String s = "";
		if (d != null)
		{
			s += Integer.toString(1900+d.getYear()) + "-";
			s += Integer.toString(100+d.getMonth()+1).substring(1) + "-";
			s += Integer.toString(100+d.getDate()).substring(1);
			if (bDateTime)
			{
				s += " ";
				s += Integer.toString(100+d.getHours()).substring(1) + ":";
				s += Integer.toString(100+d.getMinutes()).substring(1) + ":";
				s += Integer.toString(100+d.getSeconds()).substring(1);
			}
		}
		return s;
	}

	public static String genSID(int length) 
	{
		char[] SID_CH=new char[26+10];

		{
			for(char c='A';c<='Z';c++)
				SID_CH[c-'A']=c;
			for(char c='0';c<='9';c++)
				SID_CH[c-'0'+26]=c;		
		}
	
		String sid = "";
		for(int i=1;i<length;i++)
		{
			int index=(int)(Math.random()*SID_CH.length);
			sid += SID_CH[index];
		}
		return sid;
	}
%>

<%
	String js_ac_art_id = request.getParameter("js_ac_art_id");
%>

<%
	String[] news = new String[]{"","","",""};

	String sql = "";
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try
	{
			Class.forName("com.mysql.jdbc.Driver");//加载驱动
		 	String url = "jdbc:mysql://www.iactive.com.cn:3306/jaoso?useUnicode=true&characterEncoding=UTF-8";
			con = DriverManager.getConnection(url,"root","(iactive)62977749");//建立连接

			stmt = con.createStatement();
			sql = "select * from js_ac_article where js_ac_art_id = '" + js_ac_art_id + "'";
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String js_ac_art_catalog = rs.getString("js_ac_art_catalog");
				if (js_ac_art_catalog.equals("ff8080811637d0ec01163808f16d0001")) 
					js_ac_art_catalog = "news";
				else if (js_ac_art_catalog.equals("ff8080811637d0ec0116380c1ed60003")) 
					js_ac_art_catalog = "iactive-marketing";
				else if (js_ac_art_catalog.equals("f5cfdc2b3825e9fe01384c125a33001b")) 
					js_ac_art_catalog = "liveuc-marketing";
				else if (js_ac_art_catalog.equals("ff8080811637d0ec0116380c1ed60005")) 
					js_ac_art_catalog = "imm-marketing";
					
				news = new String[]{rs.getString("js_ac_art_id"), rs.getString("js_ac_art_title"), js_ac_art_catalog, rs.getString("js_ac_art_content")};
			}
			rs.close();
			stmt.close();
			con.close();
	}
	catch(SQLException e2)
	{
		out.println("数据库异常！<br>");
		out.println(e2.toString() + "<br>sql: "+sql);
	}
%>

<form name="form1" method="post" action="edit2.jsp">
<input type="hidden" id="id" name="id" value="<%=news[0]%>">

类型：
<input type="radio" id="catalog" name="catalog" value="news" <%=news[2].equals("news")? "CHECKED" : ""%>>news
<input type="radio" id="catalog" name="catalog" value="iactive-marketing"<%=news[2].equals("iactive-marketing")? "CHECKED" : ""%>>iactive-marketing
<input type="radio" id="catalog" name="catalog" value="liveuc-marketing"<%=news[2].equals("liveuc-marketing")? "CHECKED" : ""%>>liveuc-marketing
<input type="radio" id="catalog" name="catalog" value="imm-marketing"<%=news[2].equals("imm-marketing")? "CHECKED" : ""%>>imm-marketing
<br><br>

标题： <input type="text" id="title" name="title" style="width:800px" value="<%=news[1]%>">
<br><br>

内容： <textarea id="content" name="content" style="width:800px;height:500px"><%=news[3]%></textarea>
<br><br>

<input type="submit" style="width:100px" name="OK" value="提交">
<input type="reset" style="width:100px" name="reset" value="清空">
<input type="button" style="width:100px" name="return" value="返回" onclick="window.location='./'">

</form>
<script type="text/javascript">

    var editor = null;
    KindEditor.ready(function () {
        editor = KindEditor.create("#content");
    });
	function getValue()
	{
		alert(editor.html());
	}
</script>
