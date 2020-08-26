package exam;
import java.sql.*;
import java.util.*;
import java.io.*;
import coursemgmt.ExceptionsFile;

public class QuestionBody{

	Connection con;
	Statement st;
	ResultSet rs;	
	String tableName;
	int qType;
	String ansStr,hint,cFeedback,icFeedback;
	String difficultLevel,estimatedTime,timeScale;


	public void setConnection(Connection connection){
		try{
			con=connection;
			st=con.createStatement();
		}catch(SQLException se){
			ExceptionsFile.postException("QuestionBody.java","SetConnection","SQLException",se.getMessage());
			
			try{
					 if(st!=null)
						 st=null;
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
               }catch(SQLException s){
				        ExceptionsFile.postException("QuestionBody.java","closing connections in setConnection","SQLException",s.getMessage());
                        
               }
		}
	}

	public void setTblName(String tblName){
		tableName=tblName;
	}

	public ArrayList getQBody(String qId){
		int i;
		ArrayList qBody=null;
		String str;
		StringReader strReadObj;
		BufferedReader bfr;
		try{

			rs=st.executeQuery("select q_type,q_body,ans_str,hint,c_feedback,ic_feedback,difficult_level,estimated_time,time_scale from "+tableName+" where q_id='"+qId+"'");

			if (rs.next()){
				
				qType=Integer.parseInt(rs.getString("q_type"));

				str=rs.getString("q_body");
				//str=str.replaceAll("&lt;","<");
				//str=str.replaceAll("&gt;",">");
				ansStr=rs.getString("ans_str");
				hint=rs.getString("hint");
				cFeedback=rs.getString("c_feedback");
				icFeedback=rs.getString("ic_feedback");
				difficultLevel=getDifficultLevel(rs.getInt("difficult_level"));
				estimatedTime=rs.getString("estimated_time");
				timeScale=getTimeScale(rs.getInt("time_scale"));

				qBody=new ArrayList();

				strReadObj=new StringReader(str);
				bfr=new BufferedReader(strReadObj);		
				while((str=bfr.readLine())!=null){
					if(str.length()!=0)
						qBody.add(str.trim());
				}
				bfr.close();

			}	
			rs.close();		
		}
		catch(SQLException e){
			System.out.println(e.getMessage());
		}
		catch(Exception e){
			System.out.println(e.getMessage());

		}/*finally{
				 try{
                     if (con!=null){
                        st.close();
                        con.close();
                        }
               }catch(SQLException se){
				        ExceptionsFile.postException("QuestionBody.java","closing connections","SQLException",se.getMessage());
                        
               }


			}*/

		return  qBody;
   }	

	
	public int getQType(){
		return qType;
	}

	public String getAnsStr(){
		return ansStr;
	}

	public String getHint(){
		return hint;
	}

	public String getCFeedback(){
		return cFeedback;
	}

	public String getICFeedback(){
		return icFeedback;
	}
	public String getDifficultLevel(){
		return difficultLevel;
	}
	public String getEstimatedTime(){
		return estimatedTime;
	}
	public String getTimeScale(){
		return timeScale;
	}

	public String getDifficultLevel(int level){
		String difficultLevel="";
		if(level==0)
			difficultLevel="Very Easy";
		else if (level==1)
			difficultLevel="Easy";
		else if (level==2)
			difficultLevel="Average";
		else if (level==3)
			difficultLevel="Above Average";
		else if (level==4)
			difficultLevel="Difficult";
		return difficultLevel;
	}
	public String getTimeScale(int scale){
		String timeScale="";
		if(scale==0)
			timeScale="Secs";
		else if (scale==1)
			timeScale="Mins";
		else if (scale==2)
			timeScale="Hrs";
		return timeScale;
		
	}
}
