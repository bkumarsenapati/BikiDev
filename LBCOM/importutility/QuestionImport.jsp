<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<%
	String scid="";
	//final  String dbURL    = "jdbc:mysql://localhost/hsndb?user=hsn&password=whizkids";
	//final  String dbDriver = "org.gjt.mm.mysql.Driver"; 
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%	
	String param1= request.getParameter("courseid"),
	param2 = request.getParameter("classid"),
	param3 = request.getParameter("topicid"),
	param4 = request.getParameter("subtopicid"),
	param5 = request.getParameter("coursename"),
	param6 = request.getParameter("classname");
	session=request.getSession();
	String param = (String)session.getAttribute("schoolid");
	String teacherid = (String)session.getAttribute("emailid");
	
	try{
	//Class.forName(dbDriver );
	//con = DriverManager .getConnection( dbURL );
	con=db.getConnection();
	st = con.createStatement() ;
	}catch(Exception e){
		try{
		
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("QuestionImport.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
	
	
%>

<html>
<head>
<script language="javascript" >
function check(){
 

  var rrfile = document.quesimport.rfile.value;
	if ((rrfile=="")||(rrfile==null)){
			alert("select the file to import");
			document.quesimport.rfile.focus();
			return false;
		}else if ((rrfile.indexOf('.zip')==-1)&&(rrfile.indexOf('.dat')==-1)){
			alert("select the zip/dat file to import");
			document.quesimport.rfile.focus();
			return false;
		}
	document.getElementById("firstLayer").style.visibility='hidden';
	document.getElementById("statusLayer").style.visibility='visible';
	return true;
}


function getgrade(id) {
		clear(); var j=1; var i;
		for (i=0;i<studentgrade.length;i++){
			if(studentgrade[i][0]==id){
			document.quesimport.studentgrade[j]=new Option(studentgrade[i][2],studentgrade[i][1]);
				j=j+1;
			}
		} 
	}
function getcourse(id) {
		clears(); var j=1; var i;
        var schoolid=document.quesimport.schoolid.value;
		for (i=0;i<courseid.length;i++){
			if((courseid[i][1]==id)&&(courseid[i][0]==schoolid)){
			document.quesimport.courseid[j]=new Option(courseid[i][3],courseid[i][2]);
				j=j+1;
			}
		} 
	}
	
function clear() {
		var i;
		var temp=document.quesimport.studentgrade;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
		
	}
function clears() {
		var i;
		var temp=document.quesimport.courseid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
		
	}


</script>

<title>Import Utility</title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>
<body>
<p></p>
<p></p>
<p></p>

<form name= "quesimport" method="post" enctype="multipart/form-data" action="/LBCOM/importutility.GetAssessmentList2?courseid=<%=param1%>">
<input type = "hidden" name = "schoolid" value =<%= param %> >
<input type = "hidden" name = "studentgrade" value =<%= param2 %> >
<input type = "hidden" name = "courseid" value =<%= param1 %> >
<input type = "hidden" name = "topicid" value =<%= param3 %> >
<input type = "hidden" name = "subtopicid" value =<%= param4 %> >
<input type = "hidden" name = "coursename" value = <%= param5 %> >
<input type = "hidden" name = "classname" value = <%= param6 %> >

<br><br><br>

<h2 align = center ><font face="Arial" color="#000080" size="4"> Assessment Import Utility</h2><br><br>
<div align = center  name="l0" id="firstLayer" style="border:0px solid blue; background-color:'white';width=100%; ">
<font face="Arial" color="#000080" size="4">File To Import</font><INPUT type = "file" name = "rfile">
<br><input type =submit  value = Go onclick ="return check();">
</div>
<div align = center name="l2" id="statusLayer"  style="border:0px solid blue; background-color:white;width=100%; visibility:hidden">
<font size="2" face="Arial" color="#CC0066"><b>File is uploading. It will take some time. 
<br><center>Please wait....</b></font><p><img name="status" src="../images/upload.gif"></center>
</div>
<%
try{
	if(con!=null && !con.isClosed())
		con.close() ;
}catch(Exception e ){}
%>
</form>
</body>
</html>