<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0045)http://localhost:8088/DMS/JSP/foldersList.jsp -->
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="function.FindFolder"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">

<!-- <LINK href="foldersList_files/mainpage.css" type="text/css" rel=stylesheet> -->
<LINK Rel="stylesheet" Href="../CSS/mainpage.css" Type="text/css">
	<script language="Javascript" src="../JS/mainpage.js"></script>
	 <script language="Javascript" src="../JS/ajax.js"></script>
<!-- <script language="Javascript" src="../JS/simpletreemenu.js"></script> -->


<SCRIPT type="text/javascript">	
function table_select_all()
{
	
	if(form.dummy.length)
	{
	alert("hello");
	}
		else if(form.dummy.checked)
		{
				if(form.c_data.length)
			{
			for (var i=0; i < form.c_data.length; i++)
			   {
			   form.c_data[i].checked=true;
			   }
			}
			else
				{
				
					form.c_data.checked=true;
				}
			}
			else if(!form.dummy.checked)
		{
				if(form.c_data.length)
			{
			for (var i=0; i < form.c_data.length; i++)
			   {
			   form.c_data[i].checked=false;
			   }
			}
			else
				{
				
					form.c_data.checked=false;
				}
			}
	}
	</SCRIPT>

<STYLE type="text/css">
	SELECT {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px; FONT-SIZE: 100%; MARGIN: 0px; BORDER-LEFT: 0px; WIDTH: 10em; BORDER-BOTTOM: 0px; FONT-FAMILY: "Courier New", Courier; TEXT-ALIGN: left
}
</STYLE>

<META content="Microsoft FrontPage 5.0" name=GENERATOR></HEAD>
<%!
	private File filepath=null,mFilePath=null;
	private String path="",context_path="",folder_path="",mfiles="",root_path="",utype="";
	private Connection con=null;
	private Statement st=null;
	private ResultSet rs=null;
	private Hashtable ht=null;
	private DbBean bean;

%>
<%
try{
	bean=new DbBean();
	context_path=application.getInitParameter("app_path");
	root_path=application.getInitParameter("root_path");
	utype=session.getAttribute("utype").toString();

	if(request.getParameter("fol_name")!=null)
	{
		
		folder_path=request.getParameter("fol_name");
		
		
		%>
		<BODY onload="folderData('<%=folder_path.replaceAll("\\\\", "\\\\\\\\")%>')">
		<%
	}
	else if(request.getParameter("f_name")!=null)
		{
		
	String fn=request.getParameter("f_name");
	//System.out.println("test........2"+fn);
		
	%>
	<BODY onload="searchData('<%=fn%>')">
	<%
	}else{
	
	//folder_path=""+context_path+"\\WEB-INF\\textfiles";
	folder_path=session.getAttribute("r_path").toString();
		//System.out.println("test........3"+context_path+"....root_path..."+root_path);
	%>
	<BODY onload="folderDataHome();">
	<%
	}%>
<!-- <BODY onload="folderDataHome();"> -->
<FORM name="form" action="#" method="post">
<TABLE height="59" width="100%" align=center cellpadding="0" cellspacing="1">
  <TBODY>
        <TR>
            <TD width="100">
                <p align="center"><font face="Arial"><span style="font-size:10pt;"><a href="#" onclick="newFile()" style="font-family: times new roman;text-decoration:none;"><img src="../image/newdoc.png" width="32" height="32" border="0"><a></span></font></p>
            </TD>
            <TD width="100">
                <p align="center"><font face="Arial"><span style="font-size:10pt;"><a href="#" onclick="newFolder()" style="font-family: times new roman;text-decoration:none;"><img src="../image/new_folder.png" width="32" height="32" border="0"></a></span></font></p>
            </TD>
            <TD align=left width="100">
                <p align="center"><font face="Arial"><span style="font-size:10pt;"><a href="#" onclick="upload()"  style="font-family: times new roman;text-decoration:none;"><img src="../image/upload.png" width="32" height="32" border="0"></a>
</span></font>    </p>
            </TD>
<!-- 
			<td width="20%" align="left">
            <input type="button" src="../../image/upload.gif" name="button" value="Download" onclick="download()" width="60" height="20" >
			</td> --><!-- <a href="#"  onclick="cpy()" style="font-family: times new roman;text-decoration:none;height=20; width=40; border=0;" >
			<img src="../../image/copy.gif" width="40" height="20"></a></td> -->
            <TD width="100">
                <p align="center"><font face="Arial"><span style="font-size:10pt;"><a href="#" onclick="return del();"  style="font-family: times new roman;text-decoration:none;"><img src="../image/delete_big.png" width="32" height="32" border="0"></a></span></font></p>
            </TD>
            <td width="100">
                <p align="center"><font face="Arial"><span style="font-size:10pt;"><a href="#" onclick="cpy()"  style="font-family: times new roman;text-decoration:none;"><img src="../image/copy.png" width="32" height="32" border="0"></a>
</span></font>            </p>
            </td>
            <TD width="100">
                <p align="center"><font face="Arial"><span style="font-size:10pt;"><a href="#" onclick="moveFile()"  style="font-family: times new roman;text-decoration:none;"><img src="../image/cut.png" width="32" height="32" border="0"></a></span></font>
</p>
            </TD>
            <TD align=left width="100">
                <p align="center"><a href="#" onclick="zipfile()"  style="font-family: times new roman;text-decoration:none;"><img src="../image/zip.png" width="32" height="32" border="0"></a></p>
            </TD>
            <TD align=left width="100">
                <p align="center"><font face="Arial"><span style="font-size:10pt;"><a href="#" onclick="share()"  style="font-family: times new roman;text-decoration:none;"><img src="../image/share.png" width="32" height="32" border="0"></a> </span></font></p>
            </TD>
            <TD width="100">
                <p align="center"><font face="Arial"><span style="font-size:10pt;"><a href="#" onclick="searchs()"  style="font-family: times new roman;text-decoration:none;"><img src="../image/fs_search.png" width="32" height="32" border="0"></a></span></font></p>
            </TD>
        </TR>
       <TR>
            <td width="100">
                <p align="center"><a href="#" onclick="newFile()" style="font-family: times new roman;text-decoration:none;"><font face="Arial"><span style="font-size:9pt;">New Document</span></font></a></p>
            </td>
            <td width="100">
                <p align="center"><a href="#" onclick="newFolder()" style="font-family: times new roman;text-decoration:none;"><font face="Arial"><span style="font-size:9pt;">New Folder</span></font></a></p>
            </td>
            <td align="left" width="100">
                <p align="center"><a href="#" onclick="upload()"  style="font-family: times new roman;text-decoration:none;"><font face="Arial"><span style="font-size:9pt;">Upload</span></font></a></p>
`
            <td width="100">
                <p align="center"><a href="#" onclick="return del();"  style="font-family: times new roman;text-decoration:none;"><font face="Arial"><span style="font-size:9pt;">Delete</span></font></a></p>
            </td>
            <td width="100">
                <p align="center"><a href="#" onclick="cpy()"  style="font-family: times new roman;text-decoration:none;"><font face="Arial"><span style="font-size:9pt;">Copy</span></font></a></p>
            </td>
            <td width="100">
                <p align="center"><a href="#" onclick="moveFile()"  style="font-family: times new roman;text-decoration:none;"><font face="Arial"><span style="font-size:9pt;">Move</span></font></a></p>
            </td>
            <td align="left" width="100">
                <p align="center"><a href="#" onclick="zipfile()"  style="font-family: times new roman;text-decoration:none;"><font face="Arial"><span style="font-size:9pt;">Zip</span></font></a></p>
            </td>
            <td align="left" width="100">
                <p align="center"><a href="#" onclick="share()"  style="font-family: times new roman;text-decoration:none;"><font face="Arial"><span style="font-size:9pt;">Share</span></font></a></p>
            </td>
            <td width="100">
                <p align="center"><a href="#" onclick="searchs()"  style="font-family: times new roman;text-decoration:none;"><font face="Arial"><span style="font-size:9pt;">Search</span></font></a></p>
            </td>
        </TR>
</TABLE>&nbsp;
<center><font face="Arial" color="#0033FF"><span style="font-size:9pt;"><div id="path" name="path"></div></span></font></center>
<TABLE height="80%" width="100%" align=center>
 

  <TBODY>
        <TR>
            <TD vAlign=top width="20%" height="100%">
			<jsp:include page="leftFrame.jsp"/>
                <!-- <p align="center"><A href="javascript:ddtreemenu.flatten('treemenu1',%20'expand')"><font face="Arial"><span style="font-size:10pt;">View 
      All</span></font></A><span style="font-size:10pt;"><font face="Arial"> | </font><A 
      href="javascript:ddtreemenu.flatten('treemenu1',%20'contact')"><font face="Arial">Hide All</font></A><font face="Arial"><BR><BR></font></span></p>
                <p align="center">Personal</p>
                <p align="center">Shared<font face="Arial"><span style="font-size:10pt;"></span></font></p>
                <UL>
                </UL>
                <p>&nbsp;</p>
<font face="Arial"><span style="font-size:10pt;"></span></font> -->
            </TD>
            <TD vAlign=top width="80%" height="100%">
                <TABLE width="100%" align=left border=0 >
				<%
				if(utype.equals("student"))
				{
				%>
                    <TR bgcolor="#546878">
					<%
				}else{
					%>
					<tr bgcolor="#429EDF">
					<%
				}%>
                        <TD width="10%" height="24"  colspan="3"><INPUT class="" 
style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px" 
onclick="table_select_all()" type=checkbox 
value="" name=dummy>  </TD>
                        <TD width="40%"  colspan="2"><span style="font-size:10pt;"><b><font face="Arial" color="white">Name</font></b></span></TD>
                        <TD width="10%">
                            <p align="center"><span style="font-size:10pt;"><b><font face="Arial" color="white">Type</font></b></span></p>
                        </TD>
                        <td width="10%">
                            <p align="center"><span style="font-size:10pt;"><b><font face="Arial" color="white">Size</font></b></span></p>
                        </td>
                        <TD width="20%">
                            <p align="center"><span style="font-size:10pt;"><b><font face="Arial" color="white">Date</font></b></span></p>
                        </TD>
                        <td width="10%">
                            <p align="center"><span style="font-size:10pt;"><b><font face="Arial" color="white">Shared</font></b></span></p>
                        </td>
                    </TR>   
                </TABLE>
			<br><br>	
           <div id="test">
			 </div>
		  </td></tr>
		  </TBODY>
		  </table> 
		  </form>
		  <%}
		  catch(Exception e)
		  {e.printStackTrace();}%>
		  </BODY></HTML>