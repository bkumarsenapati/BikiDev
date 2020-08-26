package utility;

import java.util.*;
import javax.mail.*;
import javax.activation.*;
import javax.mail.internet.*;
import coursemgmt.ExceptionsFile;


public class SendMail{

	String host="hotschools.net";
	String from;
	public boolean sendFlag;

	public SendMail(String fr,String host){
		from=fr;
		this.host=host;
	}	
	
	public static void main(String[] args){
		//System.out.println("sendmail");

	}
	public void sendmail(String to,String sub,String pwd){
		sendFlag=false;
		try{
	
			Properties props = System.getProperties();
			props.put("mail.smtp.host", host);
			
			Session session = Session.getInstance(props, null);
			session.setDebug(false);
			//System.out.println("host in utility.java is "+host);
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(from));
			msg.addRecipients(Message.RecipientType.TO, to);
			
			msg.setSubject(sub);
			msg.setContent(pwd,"text/html");
			//msg.setText(pwd);

			/*MimeBodyPart mbp1 = new MimeBodyPart();
			mbp1.setText(pwd);

			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp1);

			msg.setContent(mp);*/

			msg.setSentDate(new java.util.Date());
			Transport.send(msg);
			sendFlag=true;
		}
		catch (MessagingException mex){
			ExceptionsFile.postException("utility.SendMail.java","SendMail","MessagingException",mex.getMessage());
			System.out.println("Messaging Exception "+mex);
		}
		catch(Exception e){
			ExceptionsFile.postException("utility.SendMail.java","SendMail","Exception",e.getMessage());
			System.out.println("General Exception "+e);
		}
		
	}
}
