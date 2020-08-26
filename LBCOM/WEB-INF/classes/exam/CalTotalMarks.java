package exam;

import java.io.*;
import java.sql.*;
import java.util.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class CalTotalMarks 
{

	DbBean con1;
	Connection con;
	Statement st;
	ResultSet rs;
	
	StringTokenizer stk,stk1;
	String groupTbl,quesString,question,group,schoolId;
	float totalMarks,marks;
	int maxQues;

    public CalTotalMarks(){
		try{	
				con1 = new DbBean();
				con = con1.getConnection();
				st=con.createStatement();
		}catch(Exception e){
				ExceptionsFile.postException("CalTotalMarks.java","constructor","Exception",e.getMessage());
				
				try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                         con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("CalTotalMarks.java","closing connections in constructor","SQLException",se.getMessage());
                        
               }
		}
	}
	
	public float calculate(String examId,String schoolId) {
		try{
			
			groupTbl=schoolId+"_"+examId+"_group_tbl";
			
			totalMarks=0;
			marks=0;
			maxQues=0;
			rs=st.executeQuery("select * from "+groupTbl);
			while(rs.next()){
				group=rs.getString("group_id");
				if(!group.equals("-")){
					maxQues=rs.getInt("ans_qtns");
					marks=rs.getFloat("weightage");
					totalMarks+=maxQues*marks;
				}
				
				
			}
			rs.close();
			rs=st.executeQuery("select * from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'");
			if(rs.next()){
				quesString=rs.getString("ques_list");
			}
			
			stk=new StringTokenizer(quesString,"#");
			while(stk.hasMoreTokens()){
				question=stk.nextToken();
				marks=0;
				stk1=new StringTokenizer(question,":");
				if(stk1.hasMoreTokens()){
					stk1.nextToken();
					marks=Float.parseFloat(stk1.nextToken());
					stk1.nextToken();
					group=stk1.nextToken();
				}
				if(group.equals("-")){
					totalMarks+=marks;
				}
			}

		   
		}catch(Exception e){
			ExceptionsFile.postException("CalTotalMarks.java","calculate","Exception",e.getMessage());
			
		}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("CalTotalMarks.java","closing connections","SQLException",se.getMessage());
                        
               }


		}

		 return totalMarks;
	}		



///**********

	public float calculateTmp(String examId,String schoolId) {
		try{
			
			groupTbl=schoolId+"_"+examId+"_group_tbl_tmp";
			
			totalMarks=0;
			marks=0;
			maxQues=0;
			rs=st.executeQuery("select * from "+groupTbl);
			while(rs.next()){
				group=rs.getString("group_id");
				if(!group.equals("-")){
					maxQues=rs.getInt("ans_qtns");
					marks=rs.getFloat("weightage");
					totalMarks+=maxQues*marks;
				}
				
				
			}
			rs.close();
			rs=st.executeQuery("select * from exam_tbl_tmp where exam_id='"+examId+"' and school_id='"+schoolId+"'");
			if(rs.next()){
				quesString=rs.getString("ques_list");
			}
			
			stk=new StringTokenizer(quesString,"#");
			while(stk.hasMoreTokens()){
				question=stk.nextToken();
				marks=0;
				stk1=new StringTokenizer(question,":");
				if(stk1.hasMoreTokens()){
					stk1.nextToken();
					marks=Float.parseFloat(stk1.nextToken());
					stk1.nextToken();
					group=stk1.nextToken();
				}
				if(group.equals("-")){
					totalMarks+=marks;
				}
			}

		   
		}catch(Exception e){
			ExceptionsFile.postException("CalTotalMarks.java","calculate","Exception",e.getMessage());
			
		}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("CalTotalMarks.java","closing connections","SQLException",se.getMessage());
                        
               }


		}

		 return totalMarks;
	}		



	
}
