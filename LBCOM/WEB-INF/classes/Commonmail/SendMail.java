package Commonmail;

import java.io.*;
import java.util.Hashtable;
import com.oreilly.servlet.MultipartRequest;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SendMail extends HttpServlet{
	private String smtpHost;
    public SendMail(){
		smtpHost = "hotschools.net";
		
	}

    public void init(ServletConfig servletconfig) throws ServletException{
        super.init(servletconfig);
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException
    {
		String fileString=null,from=null,to=null,body=null,subject=null,username=null,schoolid=null,attach=null,fileName=null;
		final String user="lbinfo@learnbeyond.com";//change accordingly
		final String password="LBmail12";//change accordingly
		HttpSession httpsession = httpservletrequest.getSession(false);
		httpservletresponse.setContentType("text/html");
		PrintWriter out = httpservletresponse.getWriter();
		ServletContext application=getServletContext();
		String host=application.getInitParameter("host");
		fileString=application.getInitParameter("attachments_path");
		//String sessid=(String)httpsession.getAttribute("sessid");
		if(httpsession==null){
			out.println("<html><script> top.location.href='/LBRT/NoSession.html'; \n </script></html>");
			return;
		}
		//fileString="C:/Tomcat 5.0/webapps/BUNDLE/mailattachmentdocs/";
		username = (String)httpsession.getAttribute("emailid");
		schoolid = (String)httpsession.getAttribute("schoolid");
		File f = new File(fileString+"/"+schoolid+"/"+username);
		if(!f.exists())
			f.mkdirs();
		MultipartRequest multipartrequest = new MultipartRequest(httpservletrequest, fileString+"/"+schoolid+"/"+username, 0xf00000);
        from = multipartrequest.getParameter("from");
        to = multipartrequest.getParameter("to");
        subject = multipartrequest.getParameter("subject");
		body = multipartrequest.getParameter("body");

		
		fileName = multipartrequest.getFilesystemName("attach");
        
		
		String s6;
        try
        {
            java.util.Properties properties = System.getProperties();
            properties.put("mail.smtp.host", host);
			properties.put("mail.smtp.auth", "true");
           //javax.mail.Session session = javax.mail.Session.getInstance(properties, null);
			 Session session = Session.getInstance(properties,
    new javax.mail.Authenticator() {
      protected PasswordAuthentication getPasswordAuthentication() {
	return new PasswordAuthentication(user,password);
      }
    });
			
            MimeMessage mimemessage = new MimeMessage(session);
            InternetAddress internetaddress = new InternetAddress(from);
            mimemessage.setFrom(internetaddress);
            InternetAddress ainternetaddress[] = InternetAddress.parse(to);
            mimemessage.setRecipients(javax.mail.Message.RecipientType.TO, ainternetaddress);
            mimemessage.setSubject(subject);
            //mimemessage.setText(body);
			if(fileName!=null){
				MimeBodyPart mimebodypart = new MimeBodyPart();
				mimebodypart.setText(body);
				MimeBodyPart mimebodypart1 = new MimeBodyPart();
				FileDataSource filedatasource = new FileDataSource(fileString+"/"+schoolid+"/"+username+"/"+fileName);
				mimebodypart1.setDataHandler(new DataHandler(filedatasource));
				mimebodypart1.setFileName(filedatasource.getName());
				MimeMultipart mimemultipart = new MimeMultipart();
				mimemultipart.addBodyPart(mimebodypart);
				mimemultipart.addBodyPart(mimebodypart1);
				mimemessage.setContent(mimemultipart);
            }
            else{
                mimemessage.setText(body);
            }
			
			Transport transport=session.getTransport("smtp");
			if (transport!=null)
			{			

			    transport.send(mimemessage);
				File f1 = new File(fileString+schoolid+"/"+username+"/"+fileName);
				if(f1.exists())
					f1.delete();
				s6 = "<br><br><center><font face=verdana size=2><b> Your message has been sent.<b></font></center>";
				out.println(s6);
				out.close();
			}

        }
        catch(AddressException addressexception)
        {
            s6 = "There was an error parsing the addresses. ";
	        out.println("<body><font face=verdana size=2>" + s6 + "..."+addressexception+"..</font></body></html>");
		    out.close();
        }
        catch(SendFailedException sendfailedexception)
        {
            s6 = "Sorry,There was an error sending the message.";
			out.println("<body><font face=verdana size=2>" + s6 + "..."+sendfailedexception+"..</font></body></html>");
			out.close();
        }
        catch(MessagingException messagingexception)
        {
            s6 = "There was an unexpected error. ";
			out.println("<body><font face=verdana size=2>" + s6 + ".."+messagingexception+"..</font></body></html>");
		    out.close();
        }
		catch (Exception genaralException)
		{
			System.out.println("Exception:"+genaralException.toString());
		}
       
    }

    
}
