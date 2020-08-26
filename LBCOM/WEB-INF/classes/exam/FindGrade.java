package exam;

import java.io.*;
import java.sql.*;
import java.util.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class FindGrade
{

	DbBean con1;
	Connection con;
	Statement st;
	ResultSet rs;
	
	boolean flage;
	int maxQues;
	int min[],max[];
	String grades[];
	String grade,gradingScale;	
    public  FindGrade(){
		try{	
				con1=new DbBean();
				con=con1.getConnection();
				st=con.createStatement();
				min=new int[20];
				max=new int[20];
				grades=new String[20];
		}catch(Exception e){
				ExceptionsFile.postException("FindGrade.java","constructor","Exception",e.getMessage());
				
		}
	}
	public String getGrade(String schoolId,String classId,String courseId,float weightedPoints) {
		try   
		{
			flage=false;
			grade="";
			gradingScale="";

			rs=st.executeQuery("select grading_scale from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"' and class_id='"+classId+"'");
			if(rs.next())
			{
				gradingScale=rs.getString("grading_scale");
				
			}
			rs.close();

			rs=st.executeQuery("select * from course_grades where courseid='"+courseId+"' and schoolid='"+schoolId+"' and classid='"+classId+"'");
			if(rs.next())
			{
				flage=true;
								
			}
			else
			{ 
				rs=st.executeQuery("select * from class_grades where schoolid='"+schoolId+"' and classid='"+classId+"'");
				if(rs.next())
					flage=true;
				
			}
			
			if(flage==true)
			{
				int i=0;
				do   
				{
					grades[i]=rs.getString("grade_code");
					if(gradingScale.equals("10scale"))
					{
						min[i]=10*rs.getInt("minimum");
						max[i]=10*rs.getInt("maximum");
					}
					else
					{
						min[i]=rs.getInt("minimum");
						max[i]=rs.getInt("maximum");
					}
					i++;
					
				}while(rs.next());
			   
			   //weightedPoints=convertToCent(marks,totalWeightage);
			
			   grade=calcGrade(min,max,grades,weightedPoints);	
			}
			else
			{
				grade="-";
			}
			
		}catch(Exception e){
			ExceptionsFile.postException("FindGrade.java","getGrade","Exception",e.getMessage());
			
		}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("FindGrade.java","closing connections","SQLException",se.getMessage());
                        
               }


		}

		 return grade;
	}		
	
	private String calcGrade(int min[],int max[],String g[],float marks){
		try{

			
			String grade;
			grade="";
			marks=Math.round(marks);
			for(int i=0;i<min.length;i++){
				if((marks>=min[i])&&(marks<=max[i])){
					grade=g[i];
					//break;
					return grade;
				}
				else
					continue;
			}
		
		}catch(Exception e){
			ExceptionsFile.postException("FindGrade.java","calcGrade","Exception",e.getMessage());
			
		}
		
		return grade;
	}
	
	public float convertToCent(float marks,float total){
		float value=0;
		try{
		    value=(100*marks)/total;

			
		}catch(Exception e){
			ExceptionsFile.postException("FindGrade.java","converToCent","Exception",e.getMessage());
			
		}
		return value;
	}
	
}
