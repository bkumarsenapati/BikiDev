package teacherAdmin;

import java.io.File;
import java.util.Vector;
import java.util.Hashtable;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import coursemgmt.ExceptionsFile;
import utility.FileUtility;

public class  GetStateStandards extends HttpServlet
{
	public void doGet(HttpServletRequest req,HttpServletResponse res){
		try{
			doPost(req,res);
		}catch(Exception e){
			ExceptionsFile.postException("GetStateStandards.java","doGet","Exception",e.getMessage());
			
		}
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		response.setContentType("text/html");
		PrintWriter out =response.getWriter();
		RequestDispatcher rd=null;
		FileUtility fu=null;
		StateStandardsParser ssp=null;
		CourseBean coursebean=null;
		String standardsPath="";

		try{
			
			ServletContext application = getServletContext();
			standardsPath=application.getInitParameter("standards_path");
			String docType=request.getParameter("doctype");
			
			
			if(fu.checkFile(standardsPath)){
				ssp=new StateStandardsParser(standardsPath);
				if(docType.equals("allstates")){
					Vector states=new Vector(2,2);
					states=ssp.getChildAttributes("state","name");
					request.setAttribute("states",states);
					rd=request.getRequestDispatcher("/coursemgmt/teacher/States.jsp");
					rd.forward(request,response);	
				}else if(docType.equals("onestate")){
					
					String stateName=request.getParameter("statename");

					String stateFilePath=ssp.getElementText("state","name",stateName);

					coursebean=new CourseBean();
					
					if(ssp.CheckFile(stateFilePath)){
						ssp=new StateStandardsParser(stateFilePath);
						
						coursebean=ssp.getAllChildElementsText();
					}else{
						coursebean=null;
					}
				request.setAttribute("statename",stateName);
				request.setAttribute("coursebean",coursebean);
				rd=request.getRequestDispatcher("/coursemgmt/teacher/StateGradesAndSubjects.jsp");
				rd.forward(request,response);
			   }
			}else{
				if(docType.equals("allstates"))
					rd=request.getRequestDispatcher("/coursemgmt/teacher/States.jsp");
				else
					rd=request.getRequestDispatcher("/coursemgmt/teacher/StateGradesAndSubjects.jsp");
				rd.forward(request,response);

			}
		}catch(Exception e){
			System.out.println("Exception in GetStateStandards at doPost is "+e);
		}

	}

	
}
