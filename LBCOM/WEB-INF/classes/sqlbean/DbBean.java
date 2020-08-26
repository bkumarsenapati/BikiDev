package sqlbean;
import java.sql.*;  
import java.io.*; 
import java.lang.*;
import javax.naming.*;
import javax.sql.*;
import coursemgmt.ExceptionsFile;

public class DbBean { 

  //variable declaration
  private       Connection        dbCon; 
  private       ResultSet         r;


  public DbBean(){  		
  } //end of DBBean1 constructor


  //closing connection explicitly 
  public void close() throws SQLException{ 
	  if(dbCon!=null){
        dbCon.close();
	  }
  } //end of close

//executing sql query

  public ResultSet execSQL(String sql) throws SQLException{ 
                    Statement s = dbCon.createStatement(); 
					r = s.executeQuery(sql); 
                    return ((r == null) ? null : r);
                    }//end of execSQL
					
  public int updateSQL(String sql) throws SQLException{                     
                   Statement s = dbCon.createStatement();
                   int c = s.executeUpdate(sql);
                   return c; 
                } //end of updateSQL

//before destroying the object, database connection will be closed

  public Connection getConnection()throws ClassNotFoundException,IOException,SQLException{  

	try{
			Context ctx = new InitialContext();
			if(ctx == null ) 
				throw new Exception("No Context");
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/hsnDB");
			if (ds != null) 
		       dbCon=ds.getConnection();              
			return dbCon;


	}catch(Exception e){
		System.out.println("Connection failure :"+ e.getMessage());
	}
	
	return dbCon;

  }

  public void close(Connection dbCon){
	  try{
			if(dbCon!=null && !dbCon.isClosed()){
				dbCon.close();
			}
			
		}catch(SQLException e){
			ExceptionsFile.postException("SQLBean.DbBean.java","close","SQLException",e.getMessage());
			
		}catch(Exception e){
			ExceptionsFile.postException("SQLBean.DbBean.java","close","Exception",e.getMessage());
		
		}

  }

}
