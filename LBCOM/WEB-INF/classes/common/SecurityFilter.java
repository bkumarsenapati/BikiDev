/*
	This filter is used for checking Checking session when  any body trying to  access the files uploaded by users(in schools folder)
	
*/
package common;
import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
public class SecurityFilter implements Filter {
	public void init(FilterConfig arg0) throws ServletException {

	}
	public void doFilter(ServletRequest req1, ServletResponse res1, FilterChain chain) throws IOException, ServletException {
		RequestDispatcher rd = null;
		HttpServletResponse res=(HttpServletResponse)res1;
		HttpServletRequest req=(HttpServletRequest)req1;
		HttpSession session=req.getSession(false);
		if(session==null){
				rd =req.getRequestDispatcher("/common/security.html");
				rd.forward(req,res);
				return;
		}
		else{
			String sessid=(String)session.getAttribute("logintype");
			if(sessid==null){
				rd =req.getRequestDispatcher("/common/security.html");
				rd.forward(req,res);
				return;
			}else{
				String requesturi=req.getRequestURI();
				if(((requesturi.indexOf("/schools/")>0)||(requesturi.indexOf("/sessids/")>0))&&((requesturi.charAt(requesturi.length()-1)=='/')||(requesturi.indexOf(".jsp")>0))){
					rd =req.getRequestDispatcher("/common/security.html");
					rd.forward(req,res);
					return;
				}
			}
		}
			
		chain.doFilter(req,res);
	}

	public void destroy() {
		//System.out.println("Security object ");
		
	}

}
//requesturi.indexOf("sessids")>0  &&(requesturi.charAt(requesturi.length()-1))=='/'