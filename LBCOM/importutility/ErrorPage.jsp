<%@ page isErrorPage="true" %>
<%@ page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<html>
<head>
<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
String errmsg="",flist="";
String errno=request.getParameter("errno");
if(errno.equals("1"))
	errmsg="Package folder name and package zip file name must be the same.";
if(errno.equals("5"))
	errmsg="This zip file cannot be extracted.";
if(errno.equals("8")){
	errmsg="Problem in some files";
	flist="File List:&nbsp;"+request.getParameter("qlist");
}
%>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<p>&nbsp;</p>
<h1><font face="Arial" size="2">
</font><font face="Arial" color="#FF0000" size="4"></font></h1>
<p><font face="Arial" size="2">
<font color="#003366"><b>There is an exception raised by your application.</b></font></font></p>
<p><font face="Arial" size="2" color="red"><b>Message:</b></font>&nbsp;<font face="Arial" size="2" ><%=errmsg%></font></p>
<p><font face="Arial" size="2" color="#003366"><%=flist%> </font></p>
<p><br></p>
<p ><font face="Arial" size="2" color="red"><b>Note:</b></font>&nbsp;<font face="Arial" size="2" >Due to this exception occured we have deleted your package. Please upload with out error.</font></p>
</body>
</html>
<%
		String schoolid =(String)session.getAttribute("schoolid");
		String bid= request.getParameter("bid");
		String url="",bname="";
		int res=0;
		try{
			Connection con=null;
			Statement st=null;
			ResultSet  rs=null;
			con=con1.getConnection();
			st=con.createStatement();
			rs=st.executeQuery("select file_name from bundles_list where bundle_id='B"+bid+"' and school_id='"+schoolid+"'");	
			if(rs.next()){
				bname=rs.getString("file_name");
			}
			res=st.executeUpdate(" delete from bundles_list where bundle_id='B"+bid+"' and school_id='"+schoolid+"'");
			String appPath=application.getInitParameter("app_path");	
			File bundle=new File(appPath+"/schools/"+schoolid+"/Assessmentszip/"+bname);
			bundle.delete();
			int blen=0;
			if(bname.indexOf(bid.substring(1)+"_")==1)blen=bid.length()+1;
			String str1 = appPath+"/schools/"+schoolid+"/Assessmentszip/"+bname.substring(blen,bname.indexOf(".zip"));
			File dir1 =new File(str1);
			String sessids_list[]=dir1.list(); 
			for(int i=0;i<sessids_list.length;i++){
				File sessDir=new File(str1+"/"+sessids_list[i]);
				if(sessDir.isFile()){
					sessDir.delete();
					continue;
				}
				String sessFiles[]=sessDir.list(); 
				for(int j=0;j<sessFiles.length;j++) 
				{
					File sessFile=new File(str1+"/"+sessids_list[i]+"/"+sessFiles[j]);
					sessFile.delete();
				}
				sessDir.delete();
			}
			dir1.delete();
			rs.close();st.close();con.close();
		}catch(Exception e){
			System.out.println(e);
		}	
	%>
