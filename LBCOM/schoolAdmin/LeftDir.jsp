<html>
<head>
	<title></title>
<script>

function checkRadio(i){
	document.forms[0].elements[i].checked=true;
}

function validFolderName(folderName){
	for(var i=0;i<folderName.length;i++){
		var ch=folderName.charAt(i);
		if(!((ch>='a' && ch<='z') || (ch==' ')|| (ch=='_') || (ch>='A' && ch<='Z') || !isNaN(ch) ))
				return false;
	}
	return true;
}


function create()
{
	var nn= prompt('Please enter a name for your folder.', 'New Folder');
           if(nn!=null){
		if(!validFolderName(nn)){
		alert("Invalid folder name");
		return; 
	}


			
		if ((nn!='') && (nn>"&#48;")){
			if (nn.length<=15)			
				window.location.href="CreatePersonalFolder.jsp?foldername="+nn;
			else{
				alert("The folder name should not exceed 15 characters");
				return;
			}

		}
		else{ 
			alert("Please enter a name for your folder");
			return;
		}

	}else return;
}


function renamefolder()
{
	var b=0;
	var size=window.document.forms[0].elements.length;

	if(size==0)
	{
		alert("There are no folders");
		return;
	}
	for(var i=0;i<size;i++)
	{
		if(window.document.forms[0].elements[i].checked)
		{
			var directory = window.document.forms[0].elements[i].value;
			var nr=prompt('Please enter a new name for your folder.', directory);
			if(nr==null)
				return;
			if(!validFolderName(nr)){
						alert("Invalid folder name");
						return; 
				}


			if (nr!=null){
				if((nr!='') && (nr>"&#48;")){				
					if (nr.length<=15){			
						b=1;
						return window.location.href="RenameFolder.jsp?newfoldername="+nr+"&foldername="+directory+"&idx="+i;
					}
					else{
						alert("The folder name should not exceed 15 characters");
						return;
					}
				}
				else{ 
					alert("Please enter a proper name for your folder");
					return;
				}
			}else return;

		}
	}
	if(b==0)
	{
		alert("Please select the folder you want to rename");
		return;
	}
}

function deletefolder()
{
	var folder;
	var bool=0;
	var size=window.document.forms[0].elements.length;
	if(size==0)
	{
		alert("There are no folders to delete");
		return;
	}
	for(var i=0;i<size;i++)
	{
		if(window.document.forms[0].elements[i].checked)
		{

			if(confirm("Are you sure you want to delete the folder?")==true){
		
				folder=window.document.forms[0].elements[i].value;
				bool==1;
				return window.location.href="DeletePersonalFolder.jsp?foldername="+folder;
			}else return;
		}
	}
	if(bool==0)
	{
		alert("Please select the folder you want to delete");
		return;
	}
}

    </script>
</head>
<body bgcolor="white">
<form name=dir target="displaymain">
<div align="left">
  <table border="0" cellspacing="4" width="100%" id="AutoNumber2">
    <tr>
      <td width="100%"><b><font size="2" face="Verdana"><a href="javascript:create()">[Create a New Folder]</a></font></b></td>
    </tr>
    <tr>
      <td width="100%">
<a href="javascript:renamefolder()"><b><font face="Verdana" size="2">
[Rename]</font></b></a></td>
    </tr>
    <tr>
      <td width="100%">
<a href="javascript:deletefolder()"><b><font face="Verdana" size="2">
[Delete]</font></b></a></td>
    </tr>
    </table>
  <hr color="#000000" align="left">
  <br>
</div>
<%@ page language="Java" import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String adminid="",foldername="",schoolid="",tag="",newfoldername="",idx="",status="";
	int flag=0,i=0;

%>
<%
	session=request.getSession(true);	
	//String dirpath="C:/Tomcat 5.0/webapps/LBCOM/schools/PersonalFolders/";
	try
	{
		adminid = (String) session.getAttribute("adminid");
		schoolid = (String) session.getAttribute("schoolid");

		tag=request.getParameter("tag");
		newfoldername=request.getParameter("newfoldername");
		idx=request.getParameter("idx");
		status=request.getParameter("status");

		i=0;
		flag=0;
		foldername="";

		con = con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select foldername from personaldocs where adminid='"+adminid+"' and schoolid='"+schoolid+"'");
		while(rs.next())
		{
			foldername=rs.getString("foldername");
%>
		<!--<table border="0" cellspacing="1" width="100%" id="AutoNumber1">
		  <tr>
		    <td width="4%"><input type="radio" value="<%= foldername %>" name="fold" onclick="javascript:parent.displaymain.location.href='ShowFiles.jsp?foldername=<%=foldername%>&adminid=<%=adminid%>&schoolid=<%=schoolid%>'"><b><font size="1.5" face="Verdana"><img border="0" src="images/Folder.gif" width="15" height="13"></font></b></td>
		    <td width="96%"><b><font size="1.5" face="Verdana">
            <a href="ShowFiles.jsp?foldername=<%=foldername%>&adminid=<%=adminid%>&schoolid=<%=schoolid%>" target="displaymain" onclick="javascript:checkRadio(<%= i %>);"><%=foldername%></a>&nbsp;</font></b></td>
		  </tr>
		  <% //i++;  %>
		</table>-->
		<table border="0" cellspacing="1" width="100%" id="AutoNumber1">
		  <tr>
			<td width="10%" align="left"><input type="radio" value="<%= foldername %>" name="fold" onclick="javascript:parent.displaymain.location.href='ShowFiles.jsp?foldername=<%=foldername%>&adminid=<%=adminid%>&schoolid=<%=schoolid%>'">
		</td>
		<td width="10%" align="left">
					<img border="0" src="images/Folder.gif" width="15" height="13">
		</td>
			<td align="left"><font face='arail' size='2'>
					<a href="ShowFiles.jsp?foldername=<%=foldername%>&adminid=<%=adminid%>&schoolid=<%=schoolid%>" target="displaymain" onclick="javascript:checkRadio(<%= i %>);"><%=foldername%></a>&nbsp;</font>
		</td>
		  </tr>
		  <% i++;  %>
		</table>




<%
			flag=1;
		}
		if(flag==0)
		{
%>
			<table border="0" cellspacing="1" width="100%" id="AutoNumber1">
			 <tr>
			    <td width="100%"><b><font size="2" face="Verdana">No folder has been created.</font></b></td>
			 </tr>
			</table>
<%	} %>


		<script>
			<% 

				if(tag!=null){

					if(tag.equals("ren")){

						out.println("document.forms[0].elements["+idx+"].checked=true;");

						if (status!=null){

						if (status.equals("success")){
							out.println("parent.displaymain.location.href='ShowFiles.jsp?foldername="+newfoldername+"&adminid="+adminid+"&schoolid="+schoolid+"'");
							out.println("alert('Successfully Renamed');");
						}
						else
							out.println("alert('Folder already exists with this name.');");
						}

					}
					else if(tag.equals("new")){
						if(status.equals("exist"))
							out.println("alert('Folder already exists with this name');");						out.println("parent.displaymain.location.href='ShowFiles.jsp?foldername="+foldername+"&adminid="+adminid+"&schoolid="+schoolid+"'");
						out.println("document.forms[0].elements["+ --i +"].checked=true;");
					}
					else if(tag.equals("del")){

						if(foldername.equals(""))
							out.println("parent.displaymain.location.href='selectpersonalfolder.html';");
						else{
						out.println("parent.displaymain.location.href='ShowFiles.jsp?foldername="+foldername+"&adminid="+adminid+"&schoolid="+schoolid+"';");
						out.println("document.forms[0].elements["+ --i +"].checked=true;");
						}

						if (status!=null){

						if (status.equals("success"))
							out.println("alert('Successfully Deleted');");
						else
							out.println("alert('Transaction Failed');");
						
						}

					}
				}

			%>

		</script>

<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("LeftDir.jsp","Operations on database ","Exception",e.getMessage());
		out.println(e);
	}
	
	finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e){System.out.println("Connection close failed");}
		
	}

%>
</form>
</body>
</html>
