package exam;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.StringTokenizer;
import java.util.Vector;

import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class LBCMSAssBuilderExamPaper 
{
	DbBean db;
	Connection con;
	Statement st;
	ResultSet rs;
	QuestionBody qtnBody;
	String courseId,schoolId,classId,qtnTbl,exmInsTbl,examId,studentId,teacherId,courseName;
	String duration,instr,examName,examType,fString,examTblName,grpTblName;
	int nQtns,durHrs,durMns,noOfGrps,nPages,importFlag;
	float totMarks;
	PrintWriter out;
	String schoolPath;
	Hashtable grpIds,grpInfo,grpST;
	boolean selfTest;
	int noOfSTQtns=0;

	public LBCMSAssBuilderExamPaper() 
	{
		try
		{	
			db = new DbBean();
			con = db.getConnection();
			st=con.createStatement();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ExamPaper.java","constructor","Exception",e.getMessage());
		}
	}

	
	public void setPaper(Hashtable verns,String examId,int nQtns,String teacherId,String qtnTbl,String schoolId,String courseId,String courseName,String schoolPath,int importFlag)
	{
		try
		{
			
			this.qtnTbl=qtnTbl;
			this.schoolId=schoolId;
			this.courseId=courseId;
			this.teacherId=teacherId;
			this.examId=examId;
			this.nQtns=nQtns;
			this.courseName=courseName;			
			this.schoolPath = schoolPath;
			grpIds=new Hashtable();
			grpInfo=new Hashtable();
			grpST=new Hashtable();
			String grpInstr;
			totMarks=0;

			
			this.importFlag=importFlag;

			if (importFlag==1)
			{
				examTblName="exam_tbl";
				//grpTblName=schoolId+"_"+examId+"_group_tbl";

			} 
			else
			{
				//examTblName="exam_tbl_tmp";
				examTblName="lbcms_dev_assessment_master";
				//grpTblName=schoolId+"_"+examId+"_group_tbl_tmp";
			}
			
			rs=st.executeQuery("select assmt_name,category_id,dur_hrs,dur_min,assmt_instructions,no_of_groups from "+examTblName+" where assmt_id='"+examId+"'");
			if(rs.next()) 
			{
				durHrs=rs.getInt("dur_hrs");
				durMns=rs.getInt("dur_min");
				examName=rs.getString("assmt_name");
				instr=rs.getString("assmt_instructions");
				noOfGrps=rs.getInt("no_of_groups");
				examType=rs.getString("category_id");
			} 
			rs.close();

			if (examType.equals("ST"))
				selfTest=true;
			else
				selfTest=false;

			if(noOfGrps>0)
			{
				
				rs=st.executeQuery("select group_id,instr,any_all,tot_qtns,ans_qtns,weightage,neg_marks from "+grpTblName+" order by group_id");
//RAJESH
				while (rs.next()) 
				{
					if(!rs.getString("group_id").equals("-"))
					{
						grpInstr=" Answer ";
						
						int totQtns=rs.getInt("tot_qtns");						
						int ansQtns=rs.getInt("ans_qtns");
						int weightage=rs.getInt("weightage");
						int negMarks=rs.getInt("neg_marks");

						String marks;
						
						if (rs.getString("any_all").equals("0"))
						{
							grpInstr=grpInstr+" all "+totQtns+" question (s)<font face='Arial' size='2' color='#800000'> &nbsp; &nbsp; ("+totQtns+"X"+weightage+" = "+totQtns*weightage+")";						
							totMarks=totMarks+(totQtns*weightage);
							
						}
						else
						{
							grpInstr=grpInstr+" any "+rs.getInt("ans_qtns")+" out of "+ rs.getInt("tot_qtns") +" questions. &nbsp; &nbsp; <font face='Arial' size='2' color='#800000'>("+ansQtns+" X "+weightage+" = "+ansQtns*weightage+")";						
							totMarks=totMarks+(ansQtns*weightage);
						}
						grpIds.put(rs.getString("group_id"),grpInstr);
						grpInfo.put(rs.getString("group_id"),new Integer(ansQtns));

					}
				} 
				rs.close();		
			}
			constructPaper(verns);		
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("LBCMSAssBuilderExamPaper.java","setPaper","Exception",e.getMessage());
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if (con!=null && !con.isClosed())
				{
					con.close();
                }
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("LBCMSAssBuilderExamPaper.java","closing connections","SQLException",se.getMessage());
            }
		}
	}


	private void constructPaper(Hashtable versns)
	{
		String dPath="";
		if (importFlag==1)
		{
			dPath= schoolPath+"/"+courseId+"/"+examId;
			
		}
		else
		{
			dPath= schoolPath+"/"+courseId+"/"+examId;
			
		}
			
		String v,qIds;

		try	
		{		
			File exmFile=new File(dPath);
			if(exmFile.exists())
			{
				String tempFiles[]=exmFile.list();			 
				for(int i=0;i<tempFiles.length;i++) 
				{
					File temp=new File(exmFile+"/"+tempFiles[i]);	   
				    temp.delete();
				}
			}
			
			exmFile.mkdirs();
			crtExmTopPanel(dPath);
			beginAnsHtml(dPath+"/answersScriptFile.html");
			for(Enumeration e = versns.keys() ; e.hasMoreElements() ;) 
			{
				v=(String)e.nextElement();
				qIds=versns.get(v).toString();
 		 		crtExmMidPanel(qIds,v,dPath);
			}		
			
			endAnsHtml(dPath+"/answersScriptFile.html");
			crtExmBmPanel(dPath);				

			StringBuffer fStringBuf =new StringBuffer(fString);

			fStringBuf.insert(fStringBuf.indexOf("$")+1,totMarks);
			fStringBuf.deleteCharAt(fStringBuf.indexOf("$"));

			RandomAccessFile exTPFile =new RandomAccessFile(dPath+"/top.html","rw");
			exTPFile.writeBytes(fStringBuf.toString());
			exTPFile.close();
		}
		catch(Exception e) 
		{
			System.out.println("Error in ExamPaper.java at construct paper is.:"+e);
		}
	}


	//// code for top panel
	private void crtExmTopPanel(String exmPath)
	{
		try
		{
			fString="";
			int pgSize,nPages;
			pgSize=5;

			fString="<html><head><meta http-equiv='Content-Language' content='en-us'>\n";
			fString=fString+"<meta http-equiv='Content-Type' content='text/html; charset=windows-1252'>\n";
			fString=fString+"<META HTTP-EQUIV='Expires' CONTENT='Mon, 04 Dec 1999 21:29:02 GMT'>\n";
			fString=fString+"<meta name='GENERATOR' content='Microsoft FrontPage 4.0'>\n";
			fString=fString+"<meta name='ProgId' content='FrontPage.Editor.Document'>\n";
			fString=fString+"<script type='text/javascript'>\n";
			fString=fString+"var hours ="+durHrs+";\n";
			fString=fString+"var minutes ="+durMns+";\n";
			fString=fString+"var seconds = 1;\n";
			fString=fString+"var timer;\n";
			fString=fString+"minutes=(((minutes < 10)&&(minutes >=0)) ? '0' : '') + minutes;\n";
			fString=fString+"hours=(((hours < 10)&&(hours >=0)) ? '0' : '') + hours;\n";
			fString=fString+"function stop(){\n";
			fString=fString+"	clearTimeout(timer);\n";
			fString=fString+"	alert('Your time is up. Your assessment has been submitted.');\n";
			fString=fString+"	parent.btm_f.go(false,'','',true);\n";
			fString=fString+"}\n";
			fString=fString+"function startClock(){	seconds = seconds-1;\n";
			if (durHrs==0 && durMns==0)
				fString=fString+"return false;\n";
			fString=fString+"	if(seconds==-1)\n";
			fString=fString+"	 {\n";
			fString=fString+"	   seconds=59;\n";
			fString=fString+"	   minutes=minutes-1;\n";
			fString=fString+"  minutes=(((minutes < 10)&&(minutes >=0)) ? '0' : '') + minutes;\n";
			fString=fString+"	 }\n";
			fString=fString+"	if(minutes==-1)\n";
			fString=fString+"	 {\n";
			fString=fString+"	   minutes=59;\n";
			fString=fString+"	   hours=hours-1;\n";
			fString=fString+"hours=(((hours < 10)&&(hours >=0)) ? '0' : '') + hours;\n";
			fString=fString+"	 }\n";
			fString=fString+"	 if(hours==0 && minutes==0 && seconds==0){\n";
			fString=fString+"			 stop();\n";
			fString=fString+"	 }\n";
			fString=fString+"	seconds=((seconds < 10) ? 	'0' : '') + seconds;\n";
			fString=fString+"	window.status= 'Time remaining  '+hours + ':' + minutes + ':' + seconds ;\n";
			fString=fString+"	timer = setTimeout('startClock()',1000)}\n";
			fString=fString+"</script>\n";

			fString=fString+"<style>\n";
			fString=fString+"	.ans {color:black}\n";
			fString=fString+"	.n_ans {color:red}\n";
			fString=fString+"</style>\n";
			 
			fString=fString+"</head>\n";

			String durTime;

			if (durHrs==0 && durMns==0)
			{
				fString=fString+"<body topmargin=0 leftmargin=3 oncontextmenu='return false;' >";
				durTime="";
			}
			else
			{		
				fString=fString+"<body topmargin=0 leftmargin=3 onLoad='startClock()' oncontextmenu='return false;'>";

				if(durHrs<10)
				{
					durTime="0"+durHrs;
				}
				else
					durTime=durHrs+"";

				if(durMns<10)
				{
					durTime=durTime+":0"+durMns;
				}
				else
					durTime=durTime+":"+durMns;
			}
		
			fString=fString+"<div align='left'>\n";
			fString=fString+"<table border='0' width='100%' cellspacing='0' cellpadding='0' height='22'>\n";
			fString=fString+"<tr>";
			fString=fString+"<td width='128' bgcolor='#B0A890' height='22'>";
			fString=fString+"<p align='left'><b><font face='Arial' size='2' color='#FFFFFF'>Submission No</font></b></td>";
			fString=fString+"<td width='7' bgcolor='#B0A890' height='22' align='center'>";
			fString=fString+"<b>";
			fString=fString+"<font color='#FFFFFF'>:</font></b></td>";
			fString=fString+"<td width='75' bgcolor='#B0A890' height='22'>&nbsp;";
			fString=fString+"<script language='javascript'>\n";
			fString=fString+"if(parent.chances!=null)\n";
			fString=fString+"document.write(parent.chances); \n";
			fString=fString+"</script>";
			fString=fString+"</td>";
			fString=fString+"<td width='556' rowspan='2' bgcolor='#B0A890' height='43'>";
			fString=fString+"<p align='center'><span style='font-variant: small-caps; font-weight: 700'>";
			fString=fString+"<font face='Arial' color='#800000'>"+examName+"</font></span></td>";
			fString=fString+"<td width='58' bgcolor='#B0A890' height='22'><font face='Arial' size='2' color='white'><b>Date</b></font></td>   ";
			fString=fString+"<td width='17' bgcolor='#B0A890' height='22'><p align='center'><b><font face='Arial' size='2' color='white'>:</font></b></p></td>";
			fString=fString+"<td width='75' bgcolor='#B0A890' height='22'><font face='Arial' size='2'>";
			fString=fString+"<SCRIPT LANGUAGE='JavaScript1.2'>";
			fString=fString+"var time=new Date();";
			fString=fString+"var month=time.getMonth() + 1;";
			fString=fString+"var date=time.getDate();";
			fString=fString+"var year=time.getYear();";
			fString=fString+"if (year < 2000)";
			fString=fString+"year = year + 1900;";
			fString=fString+"document.write(date+'-' + month+ '-'+ year );";
			fString=fString+"</SCRIPT>";
			fString=fString+"</font></td></tr>";
			fString=fString+"<tr>";
			fString=fString+"<td width='128' bgcolor='#B0A890' height='21'>";
			fString=fString+"<p align='left'><b><font face='Arial' size='2' color='#FFFFFF'>Course Contribution</font></b></td>";
			fString=fString+"<td width='7' bgcolor='#B0A890' height='21' align='center'><b><font color='#FFFFFF'>:</font></b></td>";
			fString=fString+"<td width='38' bgcolor='#B0A890' height='21'>&nbsp;$</td>";
			fString=fString+"<td bgcolor='#B0A890' height='21' width='58'><font face='Arial' size='2' color='white'><b>Duration</b></font></td>";
			fString=fString+"<td width='17' bgcolor='#B0A890' height='21'><p align='center'><b><font face='Arial' size='2' color='white'>:</font></b></p></td>";
			fString=fString+"<td width='75' bgcolor='#B0A890' height='21'>"+durTime+"</td></tr>";

			fString=fString+"<tr>";
			fString=fString+"<td  colspan='7' height='1'><b><font face='Arial' color='#FF0000'><span style='font-size:10pt;'>Instructions :</span></font></b></td></tr>";
			fString=fString+"<tr><td colspan='7'  valign='middle' align='left'><font face='Arial'><span style='font-size:10pt;'>&nbsp;*&nbsp;A checkbox is provided on the left of every question serial number to control the answer submission. ( <img src='/LBCOM/images/checked.jpg' width='18' height='18' border='0'>Submit <img src='/LBCOM/images/unchecked.jpg' width='18' height='18' border='0'> \n";
			fString=fString+"	 Do not submit)</span></font></td></tr>\n";						
			fString=fString+" <tr>\n";
			fString=fString+"      <td  valign='top'>\n";
			fString=fString+"      <p><span style='font-size:10pt;'><font face='Arial'>&nbsp;*&nbsp;"+instr+"</font></span></p>\n";
			fString=fString+"	</td></tr>\n";
			fString=fString+"<tr>\n";          			
			
			fString=fString+"<td width='100%' height='24' colspan='7'>\n";
			fString=fString+"<table border='0' cellspacing='1'  cellpadding='0' width='100%'>\n";
			fString=fString+"<tr>";

			if (noOfGrps>0)
			{
				 fString=fString+"<td>";
				 fString=fString+"            <table border='0' width='100%' cellspacing='0' cellpadding='0'>\n";
				 fString=fString+"              <tr>\n";
				 fString=fString+"                <td height='20' width='100%' bgcolor='#CCCCCC' >\n";
				 fString=fString+"                  <p align='center'><font face='Arial' size='2'>Groups</font></td>\n";
				 fString=fString+"              </tr>\n";
				 fString=fString+"              <tr>\n";
				 fString=fString+"                <td height='20' width='100%' bgcolor='#E2E2E2'>\n";
				 fString=fString+"				<p align='center'>\n";			
				 fString=fString+"				    <font face='Arial' size='2'>\n";
		 
				String gId;
				String gInstr;
		
				for(Enumeration e = grpIds.keys(); e.hasMoreElements();) 
				{
					 gId=(String)e.nextElement();
					 gInstr=grpIds.get(gId).toString();					
					 fString=fString+" <a href='#' onclick=\"go_gId('"+gId+"'); return false;\">"+gId+"</a>&nbsp;&nbsp;\n";				 
				}		
			
				fString=fString+"					</font>\n";
				fString=fString+"			  </td>\n";
				fString=fString+"              </tr>\n";
				fString=fString+"            </table>\n";
				fString=fString+"          </td>\n";       
			}	

			nPages=nQtns/pgSize;
			int nQPg=0;
			int nQtnsP=0;
			
			if (nPages>0)
			{		
				if((nQtns%pgSize)>0)
					nPages=nPages+1;
				for(int i=1;i<=nPages;i++)
				{
					fString=fString+"<td><table border='0' width='100%' cellspacing='0' cellpadding='0'>\n";
					fString=fString+"  <tr>\n";
					fString=fString+"    <td height='20' width='100%' bgcolor='#CCCCCC'>\n";
					fString=fString+"     <p align='center'><a href='#' onclick=\"go_pNo('P"+i+"');return false;\"><font face='Arial' size='2'>Page "+i+"</font></a></td>\n";
					fString=fString+"</tr>\n";
					fString=fString+"<tr>\n";
					fString=fString+"<td width='100%' bgcolor='#E2E2E2' height='20'>\n";
					fString=fString+"<div id='q_ids_"+i+"' align='center'>\n";

					nQtnsP=nQPg+pgSize;

					if (nQtnsP>nQtns)
					{
						nQtnsP=nQtns;
					}
					for(int j=(nQPg+1); j<=nQtnsP; j++)
						fString=fString+"<font face='Arial' size='2'><a href='#' onclick='go_qno("+j+"); return false;'>"+j+"</a>&nbsp;\n";				

					nQPg=i*pgSize;

					
					fString=fString+"</div>\n";
					fString=fString+"  </td>\n";
					fString=fString+"</tr>\n";
					fString=fString+"</table>\n";			
				}
			}else{


				fString=fString+"<td><table border='0' width='100%' cellspacing='0' cellpadding='0'>\n";
				fString=fString+"  <tr>\n";
				fString=fString+"    <td width='100%' bgcolor='#CCCCCC'>&nbsp;</td>\n";
				fString=fString+"</tr>\n";
				fString=fString+"<tr>\n";
				fString=fString+"<td width='100%' bgcolor='#E2E2E2' height='12'>\n";
				fString=fString+"<div id='q_ids_1' align='center'>\n";

				for(int j=1; j<=nQtns; j++)
					fString=fString+"<font face='Arial' size='2'><a href='#' onclick='go_qno("+j+"); return false;'>"+j+"</a>&nbsp;\n";				
				
				fString=fString+"</div>\n";
				fString=fString+"  </td>\n";
				fString=fString+"</tr>\n";
				fString=fString+"</table>\n";			
		}

		fString=fString+"</tr>\n";
		fString=fString+"</table>   \n";
		fString=fString+"</td>   \n";
		fString=fString+"</tr> \n";
		fString=fString+"</table>\n";
		fString=fString+"</div>\n";

		fString=fString+"</body>\n";
		fString=fString+"<SCRIPT LANGUAGE='JavaScript'>\n";
		fString=fString+"try{\n";
		fString=fString+"var vsn=parent.versn+'.html#';\n";
//		fString=fString+"	parent.mid_f.document.location.href=vsn;	\n";
		fString=fString+"function go_qno(v){	\n";
		fString=fString+"	parent.mid_f.document.location.href=vsn+v;	\n";
		fString=fString+"}\n";
		fString=fString+"function go_gId(g){\n";
		fString=fString+"	parent.mid_f.document.location.href=vsn+g;	\n";
		fString=fString+"}\n";
		fString=fString+"function go_pNo(p){\n";
		fString=fString+"	parent.mid_f.document.location.href=vsn+p;	\n";
		fString=fString+"} \n";
		fString=fString+"}catch(err){ var k=0;  }";
		fString=fString+"</SCRIPT>\n";
		fString=fString+"</html>\n";


//		RandomAccessFile exTPFile =new RandomAccessFile(exmPath+"/top.html","rw");

//		exTPFile.writeBytes(fString);
//		exTPFile.close();



		}catch(Exception e){
			System.out.println("crtExmTopPanel.."+e.getMessage());
		}
	
	}

	///////////////////////code for question paper///////////////////////////////////

	private void crtExmMidPanel(String qIds,String vNo,String exmPath)
	{
		RandomAccessFile rFile= null;
		
		try
		{
			
			
			StringTokenizer qListTkn=new StringTokenizer(qIds,"#");
			String qId,gId;
			String fText,oText,qNoStr,hint,difficultLevel,estimatedTime,timeScale,ansStr;
			ArrayList qoAList,qAList,oAList,oLList,oRList;
			int i,qNo,qType;
			float wTg,nMks;

			QuestionFormat qFormat;

			qtnBody=new QuestionBody();
			qtnBody.setConnection(con);
			qtnBody.setTblName(qtnTbl);
			oText="<html><head>\n";
			oText=oText+"<META HTTP-EQUIV='Expires' CONTENT='Mon, 04 Dec 1999 21:29:02 GMT'>\n";
			oText=oText+"<!--[if IE]>\n";
			oText=oText+"<style type=\"text/css\">\n";
			oText=oText+"*{font-family: Lucida Sans Unicode, Math1, Math2, Math3, Math4, Math5, MT Extra, CMSY10, Symbol,arial;}";
			oText=oText+"</style><![endif]-->\n";
			oText=oText+"<script language='javascript' src='/LBCOM/validationscripts.js'></script>\n";
			oText=oText+"<script language='javascript' src='/LBCOM/common/evaluation.js'></script>\n";
			oText=oText+"<!-- TinyMCE --><script type=\"text/javascript\" src='/LBCOM/tinymce/jscripts/tiny_mce/tiny_mce.js'></script><script type=\"text/javascript\">tinyMCE.init({	mode : \"textareas\",theme : \"simple\",nowrap : false,auto_focus : \"mess\",plugins : \"pagebreak,style,layer,table,save,advhr,iespell,inlinepopups,insertdatetime,preview,searchreplace,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave\",	theme_advanced_buttons1 : 'save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect',	theme_advanced_toolbar_location : \"top\",theme_advanced_toolbar_align : \"left\",theme_advanced_statusbar_location : \"bottom\",theme_advanced_resizing : true,content_css : \"css/content.css\",	style_formats : [{title : 'Bold text', inline : 'b'},{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},{title : 'Example 1', inline : 'span', classes : 'example1'},{title : 'Example 2', inline : 'span', classes : 'example2'},{title : 'Table styles'},{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}],template_replace_values : {username : \"Some User\",staffid : \"991234\"}});</script><!-- /TinyMCE -->\n";
			oText=oText+" </head>\n";
			oText=oText+"<body oncontextmenu='return false;' link='#FFFFFF' alink='#FFFFFF' vlink='#FFFFFF' leftmargin=0 topmargin=0>\n";
			oText=oText+"<form name='q_paper' enctype='multipart/form-data' action='/LBCOM/exam/SubmitShtAnsFiles.jsp?examid="+examId+"' method='post'>\n";

			qNo=1;
			Vector qId_ar=new Vector();
			Vector qType_ar=new Vector();
			int pageNo=1;
            int pgSize=5;
			nPages=0;
			String preGId="";

			if (nQtns>5)
			{
				oText=oText+"<table border='0' width='100%'><tr><td width='100%' bgcolor='#FBF4EC'><a name='P"+pageNo+"'>Page - "+pageNo+"</a></td> </tr></table>";
				nPages=nQtns/pgSize;
                if((nQtns%pgSize)>0)
                    nPages=nPages+1;			
			}

			rFile=createRandomFile(exmPath+"/answersScriptFile.html");
			while(qListTkn.hasMoreTokens())
			{								
				StringTokenizer qIdsTkn=new StringTokenizer(qListTkn.nextToken(),":");			
				qId=qIdsTkn.nextToken();
				wTg=Float.parseFloat(qIdsTkn.nextToken());
				nMks=Float.parseFloat(qIdsTkn.nextToken());
				gId=qIdsTkn.nextToken();					

				if(!gId.equals("-"))
				{
					if(!preGId.equals(gId))
					{
						String inst=(String)grpIds.get(gId);							
						if(!inst.equals(""))
						{						
							oText=oText+"<table border='0' width='100%'><tr><td width='100%' bgcolor='#FBF4EC'><a name='"+gId+"'><font face='Arial' size='2' color='#800000'>"+gId+".</font> "+(String)grpIds.get(gId)+"</a></td></tr></table>";
						}
						preGId=gId;
					}
				}
				else
				{
					totMarks=totMarks+wTg;
				}

				qId_ar.add(qId);
				qoAList=qtnBody.getQBody(qId);
				qType=qtnBody.getQType();
				ansStr=qtnBody.getAnsStr();
				ansStr=QuestionFormat.getAnswer(ansStr);
				hint=qtnBody.getHint();

				/*difficultLevel=qtnBody.getDifficultLevel();
				estimatedTime=qtnBody.getEstimatedTime();
				timeScale=qtnBody.getTimeScale();
				estimatedTime+=" "+timeScale;*/

				qType_ar.add(qType+"");
				Question qtn=new Question();					
				qtn.setQBody(qoAList);	
				qtn.setQType(qType);
				qAList =qtn.getQuestionString();					
				qNoStr=String.valueOf(qNo);
				
				//fText=QuestionFormat.getFormattedQBdy(qAList,qId,qNoStr,qType,selfTest,hint,wTg,nMks,difficultLevel,estimatedTime);		
				fText=QuestionFormat.getFormattedQBdy(qAList,qId,qNoStr,qType,selfTest,hint,wTg,nMks);		

				if(qType==3)
				{
					fText=QuestionFormat.getFormattedQnBdyForFB(fText,qId,qNoStr,wTg,gId)+"</table><br>";
					writeInToFile(rFile,"setFillInTheBlanks('"+qId+"','"+ansStr+"');"+"\n");
				}					
				
				switch(qType)
				{
					case 0: // Multiple choice
					case 1: // Multiple ansers
						oAList=qtn.getOptionStrings();							
						fText=fText+QuestionFormat.getFormattedOpnBdyForMCAndMA(oAList,qType,qId,qNoStr);
						writeInToFile(rFile,"setMultipleOptionsProperties('"+qId+"','"+ansStr+"');"+"\n");
						break;

					case 2: // True or false
						oAList=qtn.getOptionStrings();							
						fText=fText+QuestionFormat.getFormattedOpnBdyForTF(oAList,qType,qId,qNoStr);
						writeInToFile(rFile,"setMultipleOptionsProperties('"+qId+"','"+ansStr+"');"+"\n");
						break;

					case 4: // Matching
						oLList=qtn.getLOptionStrings();
					    oRList=qtn.getROptionStrings();
						fText=fText+QuestionFormat.getFormattedOpnBdyForOM(oLList,oRList,qType,qId,qNoStr);
						writeInToFile(rFile,"setMatching('"+qId+"','"+ansStr+"');"+"\n");
						break;
					case 5://  Ordering
						oLList=qtn.getLOptionStrings();						
						fText=fText+QuestionFormat.getFormattedOpnBdyForOM(oLList,null,qType,qId,qNoStr);
						writeInToFile(rFile,"setMatching('"+qId+"','"+ansStr+"');"+"\n");
						break;					
					case 6: // Short type questions
						fText=fText+QuestionFormat.getFormattedOpnBdyForST(qId,qType,qNoStr,wTg,gId);
						//writeInToFile(rFile,"setAnsFileLink(\"Q"+(i+1)+qid+"\",\"\");"+"\n");
						writeInToFile(rFile,"setShortTypeQuestion('"+qId+"','"+ansStr+"');"+"\n");
						noOfSTQtns++;
						grpST.put(gId,gId);
						break;
				}		

				oText=oText+fText;	

				if (qNo%5==0 && pageNo<nPages)
				{
					pageNo++;
					oText=oText+"<table border='0' width='100%'><tr><td width='100%' bgcolor='#FBF4EC'><a name='P"+pageNo+"'>Page - "+pageNo+"</a></td> </tr></table>";
				}
				qNo=qNo+1;
			}
			
			oText=oText+"     </form>\n";
			oText=oText+"</body>\n";
			oText=oText+"<SCRIPT LANGUAGE='JavaScript'>\n";
			oText=oText+"   var frm=document.q_paper;\n";
			oText=oText+"   var qIds=new Array();\n";
			oText=oText+"   var qType=new Array();\n\n";
				
			for(int k=0;k<qId_ar.size();k++)
			{
				oText=oText+"   qIds["+k+"]='"+ qId_ar.get(k).toString()+"'; \n qType["+k+"]="+qType_ar.get(k).toString()+"; \n";
			}

			oText=oText+"var arr=new Array();	\n";
			oText=oText+"var maxarr=new Array();	\n";
			
			

			if(noOfGrps>0){
				String tgId;
				int ansQtns,c=0;
		
				for(Enumeration e = grpST.keys(); e.hasMoreElements();) 
				{
					 tgId=(String)e.nextElement();
					 ansQtns=((Integer)grpInfo.get(tgId)).intValue();					
		 			 oText=oText+"arr["+c+"]=\""+tgId+"\";		\n";
					 oText=oText+"maxarr["+c+"]=\""+ansQtns+"\";	\n";
					 c++;
				}		

			} else{
				
				oText=oText+"arr[0]=\"-\";		\n";
				oText=oText+"maxarr[0]=\""+noOfSTQtns+"\";	\n";
			}
			
			oText=oText+"</SCRIPT>	\n";
			oText=oText+"</html>";

			RandomAccessFile exTPFile =new RandomAccessFile(exmPath+"/"+vNo+".html","rw");
			exTPFile.writeBytes(oText);
			exTPFile.close();
		}	
		catch(Exception e)
		{
			System.out.println("crtExmMidPanel..."+e.getMessage());
		}
		
		finally
		{
			try
			{
				if(rFile!=null)
					rFile.close();
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("ExamPaper.java","closing file in beginAnsHtml","Exception",e.getMessage());
			}
		}
	}

	
	private void crtExmBmPanel(String exmPath)
	{
		String fStr;
		fStr="";
		fStr=fStr+"<html><head><meta http-equiv='Content-Type' content='text/html; charset=windows-1252'>\n";
		fStr=fStr+"<meta name='GENERATOR' content='Microsoft FrontPage 4.0'><meta name='ProgId' content='FrontPage.Editor.Document'><title></title>\n";
		fStr=fStr+"<META HTTP-EQUIV='Expires' CONTENT='Mon, 04 Dec 1999 21:29:02 GMT'>\n";
		fStr=fStr+"<SCRIPT LANGUAGE='JavaScript'>;\n";
		fStr=fStr+"		var sht_type=false;\n";
		fStr=fStr+"	function c_status(){\n";

		fStr=fStr+"	var fr=parent.mid_f.document.q_paper;\n";
		fStr=fStr+"	var qIds=parent.mid_f.qIds;		\n";
		fStr=fStr+"	var qTypes=parent.mid_f.qType;\n";


		fStr=fStr+"		var c=0;	\n";
		fStr=fStr+"		for(var i=0;i<qIds.length;i++){\n";
		fStr=fStr+"			var q_id=qIds[i];\n";
		fStr=fStr+"			var qType=qTypes[i];			\n";
		fStr=fStr+"			if(qType==0 || qType==1 || qType==2){\n";
		fStr=fStr+"				for(var j=0;j<fr.elements[q_id].length;j++){\n";
		fStr=fStr+"					if(fr.elements[q_id][j].checked==true){\n";
		fStr=fStr+"						c++; break;\n";
		fStr=fStr+"					}\n";
		fStr=fStr+"				}\n";
		fStr=fStr+"			}		\n";
		fStr=fStr+"			else if (qType==4 || qType==5){\n";
		fStr=fStr+"				for(var j=0;j<fr.elements[q_id].length;j++){\n";
		fStr=fStr+"					if(fr.elements[q_id][j].value!=''){\n";
		fStr=fStr+"						c++; break;\n";
		fStr=fStr+"					}\n";
		fStr=fStr+"				}\n";
		fStr=fStr+"			}\n";
		fStr=fStr+"			else if (qType==3) {\n";
		fStr=fStr+"				if(fr.elements[q_id].length>0){\n";
		fStr=fStr+"					for(var j=0;j<fr.elements[q_id].length;j++){\n";
		fStr=fStr+"						if(fr.elements[q_id][j].value!=''){\n";
		fStr=fStr+"							c++; break;\n";
		fStr=fStr+"						}\n";
		fStr=fStr+"					}\n";
		fStr=fStr+"				}else{\n";
		fStr=fStr+"					if(fr.elements[q_id].value!='')				\n";
		fStr=fStr+"						c++;\n";
		fStr=fStr+"				}\n";
		fStr=fStr+"			} else {\n";
		fStr=fStr+"				if(fr.elements[q_id].value!='' || fr.elements[q_id+'_f'].value!='')							\n";
		fStr=fStr+"					c++;\n";
		fStr=fStr+"			}\n";
		fStr=fStr+"		}\n";
		fStr=fStr+"		refresh();\n";
		fStr=fStr+"		alert(c+' question(s) is(are) answered');\n";

		fStr=fStr+"		return; \n";
		fStr=fStr+"	}\n";



		fStr=fStr+"function go(isSingle,qId,qNo,isTimeOut){	\n";
		fStr=fStr+"		var ansStr;\n";
		fStr=fStr+"		if(isSingle==false){\n";
		fStr=fStr+"			if(isTimeOut!=true){\n";
		fStr=fStr+"				if (confirm('Are you sure that you want to submit your test?')==false)\n";
		fStr=fStr+"					return false;		\n";
		fStr=fStr+"			}\n";
		fStr=fStr+"		}else{\n";
		fStr=fStr+"			if (confirm('Do you want to view the feedback for this question?')==false)\n";
		fStr=fStr+"					return false;		\n";
		fStr=fStr+"		}\n";
		
		fStr=fStr+"		ansStr=ans_str(isSingle,qId);	\n";

		fStr=fStr+"		document.bpanel.ansstr.value=ansStr;	\n";

		fStr=fStr+"			document.bpanel.issingle.value='false';\n";
		
		fStr=fStr+"		if (isSingle==true){\n";
		fStr=fStr+"			document.bpanel.ans.value=ansStr;\n";
		fStr=fStr+"			document.bpanel.qid.value=qId;\n";
		fStr=fStr+"			document.bpanel.issingle.value='true';\n";
		fStr=fStr+"			document.bpanel.qno.value=qNo;\n";
		fStr=fStr+"		}\n";

		fStr=fStr+"		if(sht_type==true)	\n	";
		fStr=fStr+"			parent.mid_f.document.q_paper.submit();\n";
		fStr=fStr+"		else \n";
		fStr=fStr+"			 document.bpanel.submit();\n";

		fStr=fStr+" }\n\n";

		fStr=fStr+"	function ans_str(isSingle,qId){\n";

		fStr=fStr+"	var fr=parent.mid_f.document.q_paper;\n";
		fStr=fStr+"	var qIds=parent.mid_f.qIds;		\n";
		fStr=fStr+"	var qTypes=parent.mid_f.qType;\n";
		



		fStr=fStr+"		var ansStr='';	\n";
		fStr=fStr+"		sht_type=false;\n";

		fStr=fStr+"		for(var i=0;i<qIds.length;i++){\n";
		fStr=fStr+"			var q_id=qIds[i];\n";
		fStr=fStr+"			var qType=qTypes[i];\n";

		fStr=fStr+"	if (isSingle==true){\n";
		fStr=fStr+"		if (qId!=q_id)\n";
		fStr=fStr+"				continue;\n";
		fStr=fStr+"	}\n";

		fStr=fStr+"			if(qType==0 || qType==1 || qType==2){\n";
		fStr=fStr+"				for(var j=0;j<fr.elements[q_id].length;j++){\n";
		fStr=fStr+"					if(fr.elements[q_id][j].checked==true)\n";
		fStr=fStr+"						ansStr=ansStr+'1';\n";
		fStr=fStr+"					else\n";
		fStr=fStr+"						ansStr=ansStr+'0';\n";
		fStr=fStr+"				}\n";
		fStr=fStr+"			}else if (qType==4 || qType==5){\n";
		fStr=fStr+"				for(var j=0;j<fr.elements[q_id].length;j++){\n";
		fStr=fStr+"					if(fr.elements[q_id][j].value!=''){\n";
		fStr=fStr+"						ansStr=ansStr+fr.elements[q_id][j].value;\n";
		fStr=fStr+"					} else {\n";
		fStr=fStr+"						ansStr=ansStr+'-';\n";
		fStr=fStr+"					}\n";
		fStr=fStr+"				}\n";
		fStr=fStr+"			}\n";
		fStr=fStr+"			else if(qType==3){\n";
		fStr=fStr+"				if(fr.elements[q_id].length>0){\n";
		fStr=fStr+"					for(var j=0;j<fr.elements[q_id].length;j++){\n";
		fStr=fStr+"						if(fr.elements[q_id][j].value!=''){\n";
		fStr=fStr+"							ansStr=ansStr+fr.elements[q_id][j].value +'~';\n";  // Ramanujam changed the comma to ~
		fStr=fStr+"						} else {\n";
		fStr=fStr+"							ansStr=ansStr+'~';\n";  // Ramanujam changed , to ~ on 18-11-06
		fStr=fStr+"						}\n";
		fStr=fStr+"					}\n  ansStr=ansStr.substring(0,ansStr.length-1); \n ";
		fStr=fStr+"				}else{\n";
		fStr=fStr+"					if (fr.elements[q_id].value!='')\n";
		fStr=fStr+"						ansStr=ansStr+fr.elements[q_id].value;\n";
		fStr=fStr+"					else\n";
		fStr=fStr+"						ansStr=ansStr+' ';\n";
		fStr=fStr+"				}\n";
		fStr=fStr+"			} else{\n";
		fStr=fStr+"					sht_type=true;\n";
		fStr=fStr+"					if (fr.elements[q_id].value!=''  && fr.elements[q_id+'_f'].value==''){\n";
		fStr=fStr+"						ansStr=ansStr+fr.elements[q_id].value;\n";							
		fStr=fStr+"					}else\n";
		fStr=fStr+"						ansStr=ansStr+' ';				\n";
		fStr=fStr+"			}\n";	
		fStr=fStr+"			if (isSingle!=true)\n";
		fStr=fStr+"				ansStr=ansStr+'##';";
		fStr=fStr+"		}\n";
		fStr=fStr+"		if(sht_type==true)\n";
		fStr=fStr+"			document.bpanel.shorttype.value='1';\n";						

		fStr=fStr+"		return ansStr;\n";
		fStr=fStr+"	}\n";

		fStr=fStr+" function refresh(){\n";

		fStr=fStr+"	var fr=parent.mid_f.document.q_paper;\n";

//		fStr=fStr+"	var qIds=parent.mid_f.qIds;		\n";
//		fStr=fStr+"	var qTypes=parent.mid_f.qType;\n";

		fStr=fStr+"	var nqs=parent.mid_f.qIds.length;\n";
		fStr=fStr+"	var qid,view='';\n";
		fStr=fStr+"	var nPgs="+nPages+";\n";
			
		fStr=fStr+"	for(pc=1,i=1;i<=nqs;i++){\n";
		fStr=fStr+"		qid=\"Q\"+i;\n";
		fStr=fStr+"		if(fr.elements[qid].checked == true)\n";
		fStr=fStr+"			view=view+\"<a href='#' onclick='go_qno(\"+i+\")'; return false;'><font face='arial' size='2' class='ans'>\"+i+\"</font></a>&nbsp;&nbsp;\"\n";	   
		fStr=fStr+"		else\n";
		fStr=fStr+"			view=view+\"<a href='#' onclick='go_qno(\"+i+\")'; return false;'><font face='arial' size='2' class='n_ans'>\"+i+\"</font></a>&nbsp;&nbsp;\"\n";	   
				
		fStr=fStr+"		if((i%5)==0){\n";
		fStr=fStr+"			var x=parent.top_f.document.getElementById('q_ids_'+pc);\n";
		fStr=fStr+"			x.innerHTML=view;\n";
		fStr=fStr+"			view='';\n";
		fStr=fStr+"			pc++;\n";
		fStr=fStr+"		}else if(i==nqs){\n";
		fStr=fStr+"			var x=parent.top_f.document.getElementById('q_ids_'+pc);\n";
		fStr=fStr+"			x.innerHTML=view;";
		fStr=fStr+"			view='';";
		fStr=fStr+"		}\n";
		fStr=fStr+"	}\n";
		fStr=fStr+" }\n";

		fStr=fStr+"</SCRIPT>\n";
		fStr=fStr+" </head>\n";
		
		if (selfTest==false){		
			fStr=fStr+"<body leftmargin='0' oncontextmenu='return false;'><form name='bpanel' method='POST' action='/LBCOM/exam.ProcessResponse'>\n";
		}else{
			fStr=fStr+"<body leftmargin='0' oncontextmenu='return false;'><form name='bpanel' method='POST' action='/LBCOM/exam.SelfTestProcessing'>\n";
		}

		fStr=fStr+"<input type='hidden' name='ansstr'>\n";
		fStr=fStr+"<input type='hidden' name='examid' value='"+examId+"'>\n";
		fStr=fStr+"<input type='hidden' name='coursename' value='"+courseName+"'>\n";
		fStr=fStr+"<input type='hidden' name='shorttype' value='0'>\n";		
		fStr=fStr+"<input type='hidden' name='issingle' value='false'>\n";

		fStr=fStr+"<input type='hidden' name='ans' value=''>";
		fStr=fStr+"<input type='hidden' name='qid' value=''>";
		fStr=fStr+"<input type='hidden' name='qno' value=''>";

		fStr=fStr+"<table border='0' width='101%' bordercolordark='#FFFFFF' cellspacing='1' bgcolor='#B0A890'> <tr><td width='46%' valign='middle' bgcolor='#B0A890'><font face='Arial' size='2'>\n";
		fStr=fStr+"<input type='image' src='/LBCOM/images/std_status.gif' name='status' onclick='c_status();return false;'></font></td><td width='7%'>&nbsp;</td>\n";
		fStr=fStr+"<td width='49%'><p align='right'><font face='Arial' size='2'>\n";
		fStr=fStr+"<input type='image' src='/LBCOM/images/std_submit.gif' name='submit' onclick=\"go(false,'','',false);return false;\"></font></td></tr></table></form></body>\n";
		fStr=fStr+"</html>\n";


		try{
			RandomAccessFile exTPFile =new RandomAccessFile(exmPath+"/bottom.html","rw");
			exTPFile.writeBytes(fStr);
			exTPFile.close();
		}catch(Exception e){
			ExceptionsFile.postException("ExamPaper.java","crtExmBmPanel","Exception",e.getMessage());
			
		}

	}
	
	 public void beginAnsHtml(String path){
		RandomAccessFile rFile=null;
		try{
			rFile=createRandomFile(path);
			String str="";
			str=str+"<html>"+"\n";
			str=str+"<head>"+"\n";
			str=str+"<meta http-equiv='Content-Language' content='en-us'>"+"\n";
			str=str+"<meta http-equiv='Content-Type' content='text/html; charset=windows-1252'>"+"\n";
			str=str+"<meta name='GENERATOR' content='Microsoft FrontPage 4.0'>"+"\n";
			str=str+"<meta name='ProgId' content='FrontPage.Editor.Document'>"+"\n";
			str=str+"<title></title>"+"\n";
			str=str+"<script language='javascript' src='/LBCOM/validationscripts.js'></script>"+"\n";
			str=str+"<script language='javascript' src='/LBCOM/common/evaluation.js'></script>"+"\n";
			str=str+"<script language='javascript'>"+"\n";
			str=str+"function change(){"+"\n";
			writeInToFile(rFile,str);

		}catch(Exception e){
			ExceptionsFile.postException("ExamPaper.java","beginAnsHtml","Exception",e.getMessage());
			

		}finally{
			try{
				if(rFile!=null)
					rFile.close();
			}catch(Exception e){
				ExceptionsFile.postException("ExamPaper.java","closing file in beginAnsHtml","Exception",e.getMessage());
				
			}

		}
   }

   private void endAnsHtml(String path) {
	   RandomAccessFile rFile=null;
	   try{
		rFile=createRandomFile(path);
		String str="";
		str=str+"}"+"\n";
		/*str=str+"function onld(){"+"\n";
		str=str+"	var t=setTimeout('change()',1000);"+"\n";
		str=str+"}"+"\n";
		*/
		str=str+"//-->"+"\n";
		str=str+"</SCRIPT>"+"\n";
		str=str+"</head>"+"\n";
		str=str+"<body onload='onld();'>"+"\n";
		str=str+"</body>"+"\n";

		//str=str+"	<a href='#' onclick=\"parent.btm_f.location.href='/LBCOM/exam/CheckExamStatus.jsp?examid="+examId+"&createddate="+createdDate.replace('-','_')+"&version="+version+"&stupassword="+stuPassword+"'\">Do you want to submit again</a>"+"\n";
		str=str+"</body>"+"\n";
		str=str+"</html>"+"\n";
		writeInToFile(rFile,str);
		
	   }catch(Exception e) {
		   ExceptionsFile.postException("ExamPaper.java","endAnsHtml","Exception",e.getMessage());
		   
	   }finally{
		   try{
				if(rFile!=null)
					rFile.close();
			}catch(Exception e){
				ExceptionsFile.postException("ExamPaper.java","closing file in endAnsHtml","Exception",e.getMessage());
				
			}
	   }
   }
   private void endAnsHtml(String path,String examId,String createdDate,int version,String stuPassword) {
	   RandomAccessFile rFile=null;
	   try{
		   rFile=createRandomFile(path);
		String str="";
		str=str+"}"+"\n";
		str=str+"function onld(){"+"\n";
		str=str+"	var t=setTimeout('change()',1000);"+"\n";
		str=str+"}"+"\n";
		str=str+"//-->"+"\n";
		str=str+"</SCRIPT>"+"\n";
		str=str+"</head>"+"\n";
		str=str+"<body onload='onld();'>"+"\n";
		str=str+"</body>"+"\n";

		str=str+"	<a href='#' onclick=\"parent.btm_f.location.href='/MAHONING/exam/CheckExamStatus.jsp?examid="+examId+"&createddate="+createdDate.replace('-','_')+"&version="+version+"&stupassword="+stuPassword+"'\">Do you want to submit again?</a>"+"\n";
		str=str+"</body>"+"\n";
		str=str+"</html>"+"\n";
		writeInToFile(rFile,str);
	   }catch(Exception e) {
		   ExceptionsFile.postException("ExamPaper.java","endAnsHtml","Exception",e.getMessage());
		   
	   }finally{
		   try{
				if(rFile!=null)
					rFile.close();
			}catch(Exception e){
				ExceptionsFile.postException("ExamPaper.java","closing file in endAnsHtml(examId,..,..)","Exception",e.getMessage());
				
			}
	   }
   }
   private RandomAccessFile createRandomFile(String path){
	   RandomAccessFile rFile=null;
	   try{
			rFile=new RandomAccessFile(path,"rw");
	   }catch(IOException e){
		   ExceptionsFile.postException("ExamPaper.java","createRandomFile","Exception",e.getMessage());
		   
	   }
	   return rFile;
   }
   
   public void writeInToFile(RandomAccessFile rFile,String str){
           try{
                   rFile.seek(rFile.length());
                   rFile.writeBytes(str);
           }catch(IOException e){
                   ExceptionsFile.postException("ExamPaper.java","writeInToFile","Exception",e.getMessage());
                   
           }
   }

	public void destroy(){
		try{
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("ExamPaper.java","destroy","SQLException",se.getMessage());
		}
	}
	
}
