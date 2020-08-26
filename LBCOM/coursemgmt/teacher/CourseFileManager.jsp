<%@ page language="Java" import="java.io.*,java.util.*,java.lang.*,java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
  
<%!
	synchronized float recursiveSizecount(String fileString)  /* to find the size of the files/folders */
	{
		float size=0.0f;
		try{
			File file = new File(fileString);
			if(!file.exists())
				file.mkdirs();
			String filedocs[]=file.list();
			 
			if(filedocs.length>0) /* directory is not empty*/
			{
				for(int j=0;j<filedocs.length;j++)
				{
					File f1=new File(fileString+"/"+filedocs[j]);
					if(f1.isDirectory())
					{
						if((f1.list()).length != 0)
							recursiveSizecount(fileString+"/"+filedocs[j]);
					}
					else 
					{
						size+=(new File(fileString+"/"+filedocs[j])).length();
					}			
				}	
			} 	
			size+=(new File(fileString)).length();
		}catch(Exception e){
			ExceptionsFile.postException("CourseFileManager.jsp","recursiveSizeCount()","Exception",e.getMessage());
		}
		return size;
	}

%>


<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;

	Hashtable files=null;
	String teacherId="",foldername="",sectionId="",categoryId="",schoolId="",courseName="",size2="",status="",courseId="";
	String tag="",docName="",path="",disPath="",workId="",check="",rsFileName="",catType="";
	int flag=0,i=0;
	boolean fileFlag=false,isZip=false;

	float size=0.0f;


%>

<%
	String schoolpath = application.getInitParameter("schools_path");
	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	try
	{
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");
		courseName=(String)session.getAttribute("coursename");
		sectionId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		
		workId=request.getParameter("workid");
		 session.setAttribute("workid",workId);
		foldername = request.getParameter("foldername");
		session.setAttribute("foldername",foldername);
		status=request.getParameter("status");
		tag=request.getParameter("tag");
		categoryId=request.getParameter("cat");
		docName=request.getParameter("docname");
		session.setAttribute("docname",docName);
		catType=(String)session.getAttribute("catType");

		path = schoolpath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+foldername;
		
		disPath= (String)session.getAttribute("schoolpath")+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+foldername;
		fileFlag=false;
		isZip=false;
		check="false";

		session.removeAttribute("hsfiles");
		files=new Hashtable();
		con=con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select * from material_publish where work_id='"+workId+"' and school_id='"+schoolId+"'");
		int t;
		String tempStr;
		String desc;
		while(rs.next()) {
			tempStr=rs.getString("files_path");
			desc =rs.getString("description");
			t=tempStr.lastIndexOf("/");
			if (foldername.equals(tempStr.substring(0,t))) {
			   // if(i>0)
					rsFileName=tempStr.substring(t+1,tempStr.length());
				//else
				//	rsFileName=tempStr;
			//files.put(rsFileName,rsFileName);
			files.put(rsFileName,desc);
			}
		}
		session.putValue("hsfiles",files);
		

%>

<html>
<head>
	<title></title>
<link href="admcss.css" rel="stylesheet" type="text/css" />
	<base target="main">

<script language="javascript">
 var itemIds=new Array();

function extract(folder,file,cat){
	var win=window.open("ExtractFiles.jsp?foldername="+folder+"&filename="+file+"&cat="+cat,"","resizable=no,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=300,height=300,left=300,top=200");
	win.focus();
}
function validFolderName(folderName){

	for(var i=0;i<folderName.length;i++){
		var ch=folderName.charAt(i);
		if (!((ch>='a' && ch<='z') || (ch=='_') || (ch=='.') || (ch>='A' && ch<='Z') ))	{
						return false;
		}
		
	}
	return true;

}

function create(fname)
{   
	var nn= prompt('Please enter a name for the folder.', 'NewFolder');
	
			if (nn!=null) {		
					if(!validFolderName(nn)){
						alert("Invalid folder name");
						return; 
						}
					if ((nn!='') && (nn>"&#48;")){
						if (nn.length<=15) {	    	                           //window.location.href="/servlet/coursemgmt.CourseManagerFun?basefoldername="+fname+"&cat=<%=categoryId%>&mode=new&newfoldername="+nn+"&oldfoldername=&docname=<%=docName%>&workid=<%=workId%>";
						window.location.href="/LBCOM/coursemgmt.CourseManagerFun?basefoldername="+fname+"&cat=<%=categoryId%>&mode=new&newfoldername="+nn+"&oldfoldername=&docname=<%=docName%>&workid=<%=workId%>";
						}else{
							alert("The folder name should not exceed 15 characters in length");
							return;
							}

						}
					else{ 
						alert("Enter a folder name. ");
						return;
						}

			}else return;


}

function deletefolder(bfolder)
{
	var folder;
	var bool=0;
	var size=window.document.dir.elements.length;

	if(size==0)
	{
		alert("No item is available.");
		return;
	}
//alert(bfolder);
//alert(bfolder.indexOf('.cms')	);
/*if(bfolder.indexOf('.cms')!=-1){
		alert("Permission Denied.");
		return;

	}	
*/
for(var i=0;i<size;i++)
	{
		
//		if(window.document.dir.elements[i].checked)
		if((window.document.dir.elements[i].type=="radio")&&(window.document.dir.elements[i].checked))
		{   
			if(confirm("Are you ready to delete the item?")==true){
		
				folder=window.document.dir.elements[i].value;
				bool==1;
				return window.location.href="/LBCOM/coursemgmt.CourseManagerFun?basefoldername="+bfolder+"&cat=<%=categoryId%>&mode=del&newfoldername=&oldfoldername="+folder+"&docname=<%=docName%>&workid=<%=workId%>";
				}
			else
				return false;
		}
	}
	if(bool==0)
	{
		alert("Select an item to delete.");
		return;
	}
}

function renamefolder(bfolder)
{
	var b=0;
	var size=window.document.dir.elements.length;

	if(size==0)
	{
		alert("No item is available.");
		return;
	}

	for(var i=0;i<size;i++)
	{
		if(window.document.dir.elements[i].checked)
		{
			var directory = window.document.dir.elements[i].value;
			var rn=prompt('Enter a new name for file/folder.', directory);

			if (rn!=null){
					if(!validFolderName(rn)){
							alert("Invalid file/folder name.");
							return; 
					   }
					if((rn!='') && (rn>"&#48;")){				
							if (rn.length<=15){			
								b=1;
								//return window.location.href="/servlet/coursemgmt.CourseManagerFun?basefoldername="+bfolder+"&cat=<%=categoryId%>&mode=ren&newfoldername="+rn+"&oldfoldername="+directory+"&docname=<%=docName%>&workid=<%=workId%>";
								return window.location.href="/LBCOM/coursemgmt.CourseManagerFun?basefoldername="+bfolder+"&cat=<%=categoryId%>&mode=ren&newfoldername="+rn+"&oldfoldername="+directory+"&docname=<%=docName%>&workid=<%=workId%>";
							}
							else{
								alert("The file/folder name should not exceed 15 characters in length.");
								return;
							}
					}
					else{ 
						alert("Enter a proper name for your file/folder.");
						return;
					}
			}else return;

		}
	}
	if(b==0)
	{
		alert("Select the file/folder you want to rename.");
		return;
	}
	
	

}


function upload(fname,tag)
{
	
var w;
	if (tag=="zip") {
		w=window.open("SelectMultiFile.jsp?foldername="+fname+"&docname=<%=docName%>&tag=z&cat=<%=categoryId%>&workid=<%=workId%>","ZIP","resizable=no,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=300,height=300,left=300,top=200");
	} else if(tag=="cms"){


		w=window.open("/LBCOM/cms/ContFilesList.jsp?foldername="+fname+"&docname=<%=docName%>&tag=u&cat=<%=categoryId%>&workid=<%=workId%>","CMS","resizable=no,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=500,height=300,left=300,top=200");

	} else if(tag=="perdoc"){

		w=window.open("/LBCOM/cms/ContPerDoc.jsp?foldername="+fname+"&docname=<%=docName%>&tag=u&cat=<%=categoryId%>&workid=<%=workId%>","PDocs","resizable=no,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=500,height=300,left=300,top=200");

	} else {
		w=window.open("SelectMultiFile.jsp?foldername="+fname+"&docname=<%=docName%>&tag=u&cat=<%=categoryId%>&workid=<%=workId%>","General","resizable=no,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=300,height=300,left=300,top=200");
	}
    w.focus();

	
}

	function importCourseBundle(fname) 
	{
	//window.open=("/LBCOM/coursedeveloper/CourseHome.jsp");
	
	var x=window.open("/LBCOM/coursedeveloper/ImportCourse.jsp?foldername="+fname+"&docname=<%=docName%>&schoolid=<%=schoolId%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>&catid=<%=categoryId%>&materialid=<%=workId%>","General","resizable=yes,scrollbars=yes,width=800,height=500,toolbars=no");
	}

	// LBCMS
	
	function importCourseLBCMS(fname) 
	{
	//window.open=("/LBCOM/coursedeveloper/CourseHome.jsp");
	
	var x=window.open("/LBCOM/lbcms/ImportCourse.jsp?foldername="+fname+"&docname=<%=docName%>&schoolid=<%=schoolId%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>&catid=<%=categoryId%>&materialid=<%=workId%>","General","resizable=yes,scrollbars=yes,width=800,height=500,toolbars=no");
	}
	//

	function courseLinks(courseName,classId,courseId,fname)
	{
		window.location.href="WeblinksList.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&foldername="+fname+"&docname=<%=docName%>&tag=u&cat=<%=categoryId%>&workid=<%=workId%>";
		
		//var w
		//w=window.open("WeblinksList.jsp?foldername="+fname+"&docname=<%=docName%>&tag=wl&cat=<%=categoryId%>&workid=<%=workId%>&coursename="+courseName+"&classid="+classId+"&courseid="+courseId,"weblink","resizable=no,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=300,height=300,left=300,top=200");
	}

	function createFile(fname)
	{
		//window.location.href="CourseWeblinks.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
		
		var w
		w=window.open("FileEditor.jsp?foldername="+fname+"&docname=<%=docName%>&tag=u&cat=<%=categoryId%>&workid=<%=workId%>","General","resizable=no,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=300,height=300,left=300,top=200");
		w.focus();
	}

function go(path,filename) /* to open the files in the folders in a pop-up window*/
{
	//var fileName="http://183.82.48.154:8080"+path+"/"+filename;
	var fileName="http://localhost:8080"+path+"/"+filename;

	//var win=window.open(fileName,'newwindow','status=0,resizable=yes,toolbar=yes,menubar=no,titlebar=no,scrollbars=yes,width=750,height=500');

		//top.topframe.teacherCourseMaterialWin=win;
		var teacherCourseMaterialWin=window.open(fileName,'newwindow','status=0,resizable=yes,toolbar=yes,menubar=no,titlebar=no,scrollbars=yes,width=750,height=500');
		//parent.top.topframe.teacherCourseMaterialWin = window.open(fileName,'newwindow','status=0,resizable=yes,toolbar=yes,menubar=no,titlebar=no,scrollbars=yes,width=750,height=500');
		teacherCourseMaterialWin.focus();
}

function pub(pubFlag) {
	
	var checked=new Array();
	var unchecked=new Array();
	var obj=window.document.dir;
	var flag=false;

	// For files
	for(i=0,j=0,k=0;i<obj.elements.length;i++) {
	     if (obj.elements[i].type=="checkbox"){
			 if(obj.elements[i].name=="publish" && obj.elements[i].checked==true) {
				 flag=true;
	             checked[j++]=obj.elements[i].value;
			 }
			 else if(obj.elements[i].name=="publish" && obj.elements[i].checked==false) {
				 unchecked[k++]=obj.elements[i].value;
			 }
		 }
	}

	// For URLS
	var obj1=window.document.dir;
	for(i=0,j=0,k=0;i<obj1.elements.length;i++) {
	     if (obj1.elements[i].type=="checkbox"){
			 if(obj1.elements[i].name=="publish" && obj1.elements[i].checked==true) {
				 flag=true;
	             checked[j++]=obj1.elements[i].value;
			 }
			 else if(obj1.elements[i].name=="publish" && obj1.elements[i].checked==false) {
				 unchecked[k++]=obj1.elements[i].value;
			 }
		 }
	}
	
	if(flag){
	   var extFlag=false;	
	      
	   window.document.dir.checked.value=checked;
	   window.document.dir.unchecked.value=unchecked;
	         
	   if(pubFlag=="P")
		   window.document.dir.action="PublishDetails.jsp";
	   else if(pubFlag=="U")
		   window.document.dir.action="/LBCOM/coursemgmt.Publish?mode=UV";
	   else{

		   if (checked.length>1){
			   alert(" Only one file you have to select.");
			   return false;
		   }
		   if(window.document.dir.courseinfocat.value==""){
			   alert("Select category");
			   window.document.dir.courseinfocat.focus();
			   return false;
		   }

		   var catItemId=window.document.dir.courseinfocat.value;
		
		   for(var i=0;i<=itemIds.length;i++){			
			  if(itemIds[i]==catItemId){
				  if((confirm(" Link already exists for this category in Course Info. Do you want to recreate it?")==true)){
					  window.document.dir.extFlag.value="true";
					  break;
				  }else{
						return false;
				  }
			  }

		   }
		
		   window.document.dir.gencattype.value=window.document.dir.courseinfocat.value;
		   window.document.dir.action="/LBCOM/coursemgmt.GenCourseInfo";

	   }

	   window.document.dir.submit();
	     
		return false;
	}
	else {
		alert("Select the files to make available.");
		return false;
	}
}

function gotoHTML(courseName,classId,courseId,fname)
	{
		//window.location.href="WeblinksList.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&foldername="+fname+"&docname=<%=docName%>&tag=u&cat=<%=categoryId%>&workid=<%=workId%>";

		window.location.href="HTMLEdit.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&foldername=<%=foldername%>&filename="+fname+"&cat=<%=categoryId%>&workid=<%=workId%>&docname=<%=docName%>";
	}

    </script>
<script>
			<% 

				if(tag!=null){

					if(tag.equals("ren")){

						if (status!=null){
							//out.println("document.dir.elements["++"].checked=true;");
						if (status.equals("success")){
							
							out.println("alert('Successfully Renamed');");
						}
						else
							out.println("alert('Folder already exists with this name.');");
						}

					}
					else if(tag.equals("new")){
					
						if(status.equals("exist"))
							out.println("alert('Folder already exists with this name.');");	
							
						
					}
					else if(tag.equals("del")){

							if (status!=null){

						       if (status.equals("success"))
								   out.println("alert('Successfully deleted');");
						       else
								   out.println("alert('Transaction failed');");
						
						}

					}
				}

			%>
</script>

</head>
<body topmargin=5>
<form name="dir" target="bottompanel" method="post">

<div align="center">
  <center>

<table border="4" width="100%" cellspacing="1" bordercolor="#BBB6B6">
  <tr>
    <td width="100%" align="left" height="40">
    
    <TABLE border="4"  id='menus'  width="100%" border=0 cellpadding="0" cellspacing="0" height="43" bordercolor="#BBB6B6">
<TBODY>

 <TR >
   <TD >
                    <p align="center"><a href="#" onClick="create('<%=foldername%>'); return false;"><img src="images/create_folder.png" border="0" TITLE="Create Sub Folder"></a></B></TD>

   <TD>
                    <p align="center"><a href="#" onClick="deletefolder('<%=foldername%>'); return false;"><img src="images/delete-file-icon.png" border="0" TITLE="Delete"></a> </TD>

<!--   <TD align=left height="20" valign="middle" bgcolor="#BEC9DE" width="151" style="border-style: solid; border-width: 1">
                    <p align="center"><B>[<!-- <a href="#" onclick="renamefolder('<%=foldername%>'); return false;"><FONT face="Arial" size="2" color="#000080">Rename</FONT></a> </B></TD> -->

   <TD>
                    <p align="center">  <a href="#" onClick="upload('<%=foldername%>','unzip'); return false;"><img src="images/import_from_lbcms.png" border="0" TITLE="Upload Files"></FONT></a> </TD>
	<TD>
                    <p align="center">  <a href="#" onClick="importCourseBundle('<%=foldername%>');  return false;"><img src="images/import-icon.png" border="0" TITLE="Import from Builder"></FONT></a> </TD>

					<TD>
                    <p align="center">  <a href="#" onClick="importCourseLBCMS('<%=foldername%>');  return false;"><img src="images/import-icon.png" border="0" TITLE="Import from Builder"></FONT></a> </TD>

  <!--  <TD align=left height="20" valign="middle" bgcolor="#BEC9DE" width="155" style="border-style: solid; border-width: 1">
                    <p align="center"> <B>[ <a href="#" onclick="upload('<%=foldername%>','cms'); return false;"><FONT face="Arial" size="2" color="#000080">Upload Files from CMS</FONT></a> ]</B></TD> -->

			<TD>
				 <p align="center">
			<a href="#" onclick="courseLinks('<%=courseName%>','<%=sectionId%>','<%=courseId%>','<%=foldername%>');return false;"><img src="images/link_add.png" border="0" TITLE="Add a Web Link"></a></p>
					</td>
<TD>
						 <p align="center">
						<a href="#" onclick="createFile('<%=foldername%>');return false;"><img src="images/create_file.png" border="0" TITLE="Create File"></a></p>
					</td>

	 <TD>
                    <p align="center"><a href="#" onClick="upload('<%=foldername%>','zip'); return false;"><img src="images/upolod_zipfile.png" border="0" TITLE="Upload Zip Files"></FONT></a> </TD>

   <!--  <TD align=left height="20" valign="middle" bgcolor="#BEC9DE" width="155" style="border-style: solid; border-width: 1">
                    <p align="center"> <B>[ <a href="#" onclick="upload('<%=foldername%>','perdoc'); return false;"><FONT face="Arial" size="2" color="#000080">Upload Files from Personal Docs</FONT></a> ]</B></TD>	 -->	    		    
		    
	<TD>
                    <p align="right"><a href="CourseFileManager.jsp?workid=<%=workId%>&foldername=<%=foldername%>&docname=<%=docName%>&cat=<%=categoryId%>" target="bottompanel" ><img src="images/refresh.png" border="0" TITLE="Refresh"></a> </TD></tr>
</center>
</table>




 <tr>
	<TD>
                   
					
<!-- <a href="../coursemgmt/dbitemcoursetoppanel.jsp?cat=<%=categoryId%>">Back&nbsp;&nbsp;</a> -->


<%
	if (foldername.indexOf(".cms")!=-1){
	out.println("<script>");
//	out.println("alert(document.getElementById('menus').style.visibility);");
	out.println("document.getElementById('menus').style.visibility='hidden';");
	out.println("</script>");
	}

	  
	  
	  %>
 


</TD>
 </tr>
</TBODY></TABLE>
    
    </td>
  </tr>

 
  <tr>
    <td width="100%" align="left" height="60">
     <TABLE border="4"  id=AutoNumber1 cellSpacing='0'  width='100%' border="0" cellpadding="0" bordercolor="#000000"><TBODY>
	<TR >
		<TD class="gridhdr"  align="left"  width='50%'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name</span> </TD>
	
		<td class="gridhdr" align="left"  width='50%'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Size</span>
		</td>
		</TR></tbody>
		</table>
		<TABLE border="4"  id=AutoNumber1 cellSpacing='0'  width='100%' border="0" cellpadding="0" bordercolor="#000000"><TBODY>
<tr>
<td width="100%">
<!-- Santhosh Added from here to display the weblinks --- created date 10/2/2012   -->


<%
	/*
		st1 = con.createStatement();
		rs1= st1.executeQuery("select title,titleurl from courseweblinks where course_id= '"+courseId+"' and school_id='"+schoolId+"'");	
		boolean webflag=false,urlpublish=false;
		int y=0;

%>
 <%
	out.println("<table width='100%'><tr>");
 while(rs1.next())
 {   	
   String webTitle = rs1.getString("title");
   String weburl = rs1.getString("titleurl");
   urlpublish=false;
		
		st2 = con.createStatement();
		rs2= st2.executeQuery("select * from material_publish where work_id='"+workId+"' and school_id='"+schoolId+"' and SUBSTRING(files_path,7)='"+webTitle+"'");
		if(rs2.next())
	 	 {
			urlpublish=true;

		 }
		 st2.close();
		 rs2.close();
   String adturl=weburl;
   String chkstatus="",stsClr="",stsMsg="";

   if(!adturl.startsWith("http://"))
	 {
	   adturl="http://"+adturl;
	   
	 }
	 if(urlpublish==true)
	 {
		 chkstatus="checked";
		 stsClr="green";
		 stsMsg="The Weblink is assigned to the student(s).";
	 }
	 else
	 {
		 chkstatus="";
		 stsClr="red";
		 stsMsg="The Weblink is not assigned to the student(s).";
	 }
	    	
	out.println("<tr><td height='25' width='4%' align=\"left\"><font face='Arial' size='3'><input type=radio name=publish value='"+webTitle+"'></font></td><td  bgcolor="+stsClr+" height='25' width='1%' align=\"left\"><font face='Arial' size='3'><input type=checkbox name=publish value='"+webTitle+"'  title=\""+stsMsg+"\"></font></td><td align=\"left\"  height='25' width='40%'> <font face='Arial' size='2'><a href="+adturl+" target='_Blank'>"+webTitle+"</a></font> </td>  <td align=\"left\"  height='25' width='40%'> <font face='Arial' size='2'>"+adturl+"</font> </td></tr>");

	webflag=true;
 }
 rs1.close();
 st1.close();

 if(!webflag)
		{
			out.println("<tr><td height='25' colspan='3' valign='center' ><font face='Arial' size='2'> Web Links are yet to be provided</font> </td></tr>");
		}
		
out.println("</tr></table><hr>");
*/
%>
<!-- Weblinks upto here   -->
</td>
</tr>
</table>
<table>

  <%
	 String parent="";
	String str[]=foldername.split("/");
    if(str.length==1) {
		parent=str[0];	%><%=docName%>

	<%} 
		else  {
			parent="";
			for(i=0;i<str.length-1;i++) {
		  		
				if (parent.equals(""))
					parent=str[i];
				else
					parent+="/"+str[i];
				
				if (i==0) { 
				 
						out.println("<a href='CourseFileManager.jsp?workid="+workId+"&foldername="+parent+"&docname="+docName+"&cat="+categoryId+"' target='bottompanel'>"+docName+"</a>/");  	 
				} else {
						out.println("<a href='CourseFileManager.jsp?workid="+workId+"&foldername="+parent+"&docname="+docName+"&cat="+categoryId+"' target='bottompanel'>"+str[i]+"</a>/");			
				}
			} out.println(str[i]+"/");
		}		
	  
	   /*if(parent.endsWith("/"))	
		{
				parent = parent.substring(0,parent.length()-1);

		}*/		 
  %>
  <center>
  
<%

	    int j=0;
		File  temp=new File(path);
		String filelist[] = temp.list();
		String[] str1;				
		flag=0;					
		for(i=0;i<filelist.length;i++)    /*If the folder contains sub folders*/
	    { 
		  if((new File(path+"/"+filelist[i])).isDirectory())
	      {
			size = 0;			
		    size=recursiveSizecount(path+"/"+filelist[i]); 
			size/=1024;
			size2 = size+"";
			size2 = size2.replace('.','_');
			str1 = size2.split("_");
			size2 = str1[0]+"."+((str1[1].length()<9)?str1[1].substring(0,1):str1[1].substring(0,2));

			System.out.println("filelist[i]..."+filelist[i]);
%>		
		<TR>
			<TD width=15>
            <INPUT type=radio value="<%=filelist[i]%>" name="dir"></TD>
	
			<TD  width=15>
            <IMG height=14 src="../images/Folder.gif" width=15 border=0 align="left"></TD>

		<TD  width="50%"><a href="CourseFileManager.jsp?workid=<%=workId%>&foldername=<%=foldername%>/<%=filelist[i]%>&docname=<%=docName%>&cat=<%=categoryId%>" target="bottompanel"><FONT face=Arial><%=filelist[i]%></FONT></a></TD>

  </center>
			<!-- <TD>&nbsp;</TD> -->
			<TD>&nbsp;
              <%= size2 %> KB
  </TD>
		</TR>
  <center>
<%
			++j;
		  }
			flag=1;
        }
		 int pos=0;		

		 System.out.println("filelist..."+filelist);
         for( i=0;i<filelist.length;i++) /* If the folder contains the files*/
	     {
			 
		    if(!(new File(path+"/"+filelist[i])).isDirectory())
	        {
              if (files.containsKey(filelist[i])){
				  check="true";
			  }
			  else
				  check="false";
			  pos=filelist[i].lastIndexOf(".");
			  
			  if (filelist[i].substring(pos+1,filelist[i].length()).equals("zip")){
				  isZip=true;
				  
			  }
			  else{
				  isZip=false;
  				  
			  }
			  fileFlag=true;
		      size = (new File(path+"/"+filelist[i])).length();
			  size = size/1024;
	          size2 = size+"";
			  size2 = size2.replace('.','_');
			  str1 = size2.split("_");
			  size2 = str1[0]+"."+((str1[1].length()<9)?str1[1].substring(0,1):str1[1].substring(0,2)); 
			  String stsClrFiles="",stsMsgFiles="";

 %>
		<TR>
			<TD>
			<INPUT type=radio value="<%=filelist[i]%>" name="dir"></TD>
			<%if (check.equals("false")) {
			stsClrFiles="red";
			 stsMsgFiles="The File is not assigned to the student(s).";
			%>

				<TD bgcolor=<%=stsClrFiles%> width="1%">
			    <input type="checkbox" name="publish" value="<%=filelist[i]%>" title="<%=stsMsgFiles%>"></TD>
			<%}else {
					stsClrFiles="green";
					  stsMsgFiles="The File is assigned to the student(s).";
					%>
				<TD bgcolor=<%=stsClrFiles%> width="1%">
			    <input type="checkbox" name="publish" value="<%=filelist[i]%>" title="<%=stsMsgFiles%>"></TD>
			<%}%>

			<TD>
		
            <a href="#" onClick="go('<%=disPath%>','<%=filelist[i]%>'); return false;"><FONT face=Arial><%=filelist[i]%></FONT></a></TD>

			<%

				int ishtml=filelist[i].lastIndexOf(".");
				System.out.println("checking for html");
				System.out.println(filelist[i].substring(ishtml+1));
			  
			  if (filelist[i].substring(ishtml+1).equals("html") || filelist[i].substring(ishtml+1).equals("htm"))
				{
				  System.out.println("html caught");

				  %>
		
						<td>
						<!-- <a href="HTMLEdit.jsp?foldername=<%=foldername%>&filename=<%=filelist[i]%>&cat=<%=categoryId%>&workid=<%=workId%>&docname=<%=docName%>"><img border="0" src="images/iedit.gif" TITLE="Extract files here." target="bottompanel"></a>  -->

						<a href="#" onclick="gotoHTML('<%=courseName%>','<%=sectionId%>','<%=courseId%>','<%=filelist[i]%>');return false;"><img src="images/iedit.gif" border="0" TITLE="Edit a file"></a>
						</td>
			<%
			  }
			%>
			<%if (isZip){%>
			    <TD>
			    <a href="ExtractFiles.jsp?foldername=<%=foldername%>&filename=<%=filelist[i]%>&cat=<%=categoryId%>&workid=<%=workId%>&docname=<%=docName%>" target="bottompanel"><img border="0" src="../images/zipicon.gif" TITLE="Extract files here."></a></TD>
					
			<%}else{%>
				<!-- <TD>&nbsp;</TD> -->
			<%}%>

  </center>

			<TD>&nbsp;
             <%=size2%> KB
  </TD>
		</TR>	

	<TR><TD ></td></TR>


  <center>
<%	  
			  ++j;
		    }
		  flag=1;
		}
			
		if(flag==0) /*If the folder is empty*/
		{
			
			out.println("<tr><TD width='970' colspan='5' style='border-width:1pt; border-color:black; border-style:solid;'><DIV align='center'><b><p id='AutoNumber2'><font face='verdana' size='2' color='#666699'><--- No Files/Folders ---></font></p></b></DIV></TD></tr>");

		}	
		if (fileFlag) {
		     out.println("<TR><TD width='300' colspan='3' ><DIV align='left'><b><font face='verdana' size='2' color='#116699'>Make&nbsp;<a href='#' OnClick='pub(\"P\"); return false;'><font color='#000080'>Available</a>&nbsp;/");
			 
			 if(files.size()==0)
					out.println("unavailable");
			 else
				 out.println("<a href='#' OnClick='pub(\"U\"); return false;'>Unavailable </a>");
			

			 out.println("to students</font></font> </b> </DIV></TD>");
			 
			if(catType.equals("CM")){
				rs=st.executeQuery("Select item_id,item_des from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and category_type='CO'");				

		%>

				
				<TD width='600' colspan='2'><DIV align='right'>
					Generate Course Info
					<select size="1" name="courseinfocat" >
					<option value="" selected>Select</option>
					<%
						while(rs.next()){
							out.println("<option value='"+rs.getString("item_id")+"'>"+rs.getString("item_des")+"</option>");	
						}
						rs.close();
					%>
					</select></font></b>
					<input type="button" name="gon" value="Go" onClick="pub('G');"></DIV>
					</TD>

					<script language="javascript">
					

					<%
						rs=st.executeQuery("Select item_id from category_index_files where school_id='"+schoolId+"' and course_id='"+courseId+"'");	
						int c=0;
						while(rs.next()){
							out.println("itemIds["+c+"]='"+rs.getString("item_id")+"';");
							c=c+1;
						}
						rs.close();
					%>

					</script>


					
		
		<%
			}
		}
	%>

	</TR>
		
<%
}
	catch(Exception e)
	{
		ExceptionsFile.postException("CourseFileManager.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
	    out.println("Exception in Filemanager that is:"+e);
	}finally{
		try{
		
			if(st!=null){
				st.close();
			}
			if(con!=null && !con.isClosed()){
				con.close();
			}
			
		}catch(SQLException se){
			ExceptionsFile.postException("CourseFileManager.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("Exception in CourseFileManager.jsp is..."+se.getMessage());
		}

    }
%>
	<input type="hidden" name="checked" value="">
	<input type="hidden" name="unchecked" value="">
	<input type="hidden" name="workid" value="<%=workId%>">
	<input type="hidden" name="path" value="<%=foldername%>">
	<input type="hidden" name="docname" value="<%=docName%>">
	<input type="hidden" name="cat" value="<%=categoryId%>">
	<input type="hidden" name="gencattype" value="">
	<input type="hidden" name="extFlag" value="">
    
</table>
</form>
</center>
</table>
</div>
</body>
