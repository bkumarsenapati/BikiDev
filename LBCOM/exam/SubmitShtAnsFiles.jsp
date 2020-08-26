<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%@ page language="java" contentType="text/html" import = "java.io.*,com.oreilly.servlet.*,coursemgmt.ExceptionsFile" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;	
	
	String schoolId="",schoolPath="",teacherId="",studentId="",courseId="",gradeId="",examId="",examTable="",attempt="";
	String mode="";
	String extFileList[]=null;

			mode=request.getParameter("mode");
			if(mode==null || mode.equals(""))
				mode="S";
			else
				mode="T";

			if(mode.equals("T")){
				studentId=request.getParameter("studentid");
//				attempt=Integer.parseInt(req.getParameter("attempt"));
			}
			else{
				studentId=(String)session.getAttribute("emailid");
			}


			schoolPath = application.getInitParameter("schools_path");
			schoolId=(String)session.getAttribute("schoolid");
			courseId=(String)session.getAttribute("courseid");
			gradeId=(String)session.getAttribute("classid");
			attempt=request.getParameter("attempt");
			examId=request.getParameter("examid");

		try{	
			con = con1.getConnection();
			st=con.createStatement();
			rs=st.executeQuery("select exam_name,exam_type,create_date,teacher_id from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'");
	
			if (rs.next()) {
				examTable=schoolId+"_"+examId+"_"+rs.getString("create_date").replace('-','_');
				teacherId=rs.getString("teacher_id");
			}

			int no=0;
			String path="";
	 		if(mode.equals("S")){
				rs=st.executeQuery("select count(*) from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"'");
				if(rs.next())
					no=rs.getInt(1);
				path=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+no;
				File exmFile=new File(path);		
				exmFile.mkdirs();
				if(attempt!=null){
				String oldpath=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+attempt;	
				File oldFile=new File(oldpath);
				extFileList = oldFile.list();	
				for(int i=0;i<extFileList.length;i++)   
				{  
					if(extFileList[i].indexOf("_")==-1)
						continue;
					FileInputStream fis = new FileInputStream(oldFile.getAbsolutePath()+"/"+extFileList[i]);
				    FileOutputStream fos = new FileOutputStream(exmFile.getAbsolutePath()+"/"+extFileList[i]);
					byte[] buf = new byte[2048];
			        int j = 0;
				    while((j=fis.read(buf))!=-1) {
						fos.write(buf, 0, j);
					}	
					fis.close();
				    fos.close();			
				}
			
			}
			
			} else{
				path=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+attempt;
			}


			MultipartRequest mrequest = new MultipartRequest(request, path,10*1048576);
			Enumeration e=mrequest.getFileNames();
			String fileName;
			String fileSysName;

			for(;e.hasMoreElements();){
				fileName=e.nextElement().toString();
				fileSysName=mrequest.getFilesystemName(fileName);
				File f=mrequest.getFile(fileName);
				
			if(f!=null){
				
				fileSysName=fileSysName.substring(fileSysName.lastIndexOf("."),fileSysName.length());				
				//File t=new File(path+"/"+fileName.substring(0,fileName.indexOf('_')+1)+"response"+fileSysName);

				String fPrimaryName=fileName+"_response";
								

				if(mode.equals("S") && attempt!=null ){

					for(int i=0;i<extFileList.length;i++)   
					{  
						if(extFileList[i].indexOf("_")==-1)
							continue;
						System.out.println(extFileList[i].substring(0,extFileList[i].indexOf(".")+1));
						System.out.println(fPrimaryName);

						if(extFileList[i].substring(0,extFileList[i].indexOf(".")).equals(fPrimaryName)){
					
							File dFile=new File(path+"/"+extFileList[i]);
							if(dFile.exists())
								dFile.delete();

						}

					}
				}

				File t=new File(path+"/"+fileName+"_response"+fileSysName);
				if(t.exists())
					t.delete();
				f.renameTo(t);
				
				

			}
		}       
       
    }
	catch(Exception e)
	{
		ExceptionsFile.postException("SubmitShtAnsFiles.jsp","operations on database","Exception",e.getMessage());
			System.out.println("The Error: SQL - "+e.getMessage());

	}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed()){
				con.close();
			}
			
		}catch(SQLException se){
			ExceptionsFile.postException("GroupDetails.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>
</head>
<BODY>
<b>Your assessment has been submitted.</b>
<script>
<%	if(mode.equals("T")){ %>
	parent.btm_f.document.bpanel.action='/LBCOM/exam.ProcessResponse?mode=T&studentid=<%=studentId%>&attempt=<%=attempt%>';
<% } %>
	parent.btm_f.document.bpanel.submit();
</script>
</BODY>
</HTML>
