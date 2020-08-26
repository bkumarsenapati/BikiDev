// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/2/2012 12:10:32 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   StudentReplyForum.java

package forums;

import com.oreilly.servlet.MultipartRequest;
import coursemgmt.ExceptionsFile;
import java.io.File;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.*;
import sqlbean.DbBean;
import utility.FileUtility;

public class StudentReplyForum extends HttpServlet
{

    public StudentReplyForum()
    {
    }

    public void init(ServletConfig servletconfig)
    {
        try
        {
            super.init(servletconfig);
        }
        catch(Exception exception)
        {
            ExceptionsFile.postException("StudentReplyForum.java", "init", "Exception", exception.getMessage());
        }
    }

    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
        Connection connection = null;
        Object obj = null;
        Object obj1 = null;
        Object obj2 = null;
        Object obj3 = null;
        Object obj4 = null;
        Object obj5 = null;
        Object obj6 = null;
        Object obj7 = null;
        Object obj8 = null;
        Statement statement = null;
        Object obj9 = null;
        Object obj10 = null;
        Object obj11 = null;
        Object obj12 = null;
        Object obj13 = null;
        Object obj14 = null;
        Object obj15 = null;
        Object obj16 = null;
        Object obj17 = null;
        Object obj18 = null;
        Object obj19 = null;
        Object obj20 = null;
        Object obj21 = null;
        Object obj22 = null;
        Object obj23 = null;
        Object obj24 = null;
        Object obj25 = null;
        Object obj26 = null;
        String s15 = "";
        String s17 = "";
        String s19 = "";
        String s21 = "";
        String s23 = "";
        String s25 = "";
        String s26 = "";
        String s28 = "";
        String s30 = "";
        String s32 = "";
        ServletContext servletcontext = getServletContext();
        String s34 = servletcontext.getInitParameter("forum_path");
        try
        {
            httpservletresponse.setContentType("text/html");
            String s1 = httpservletrequest.getParameter("sid");
            String s3 = httpservletrequest.getParameter("fid");
            String s11 = httpservletrequest.getParameter("dir");
            String s12 = httpservletrequest.getParameter("user");
            String s14 = httpservletrequest.getParameter("puser");
            String s13 = httpservletrequest.getParameter("postdate");
            String s16 = httpservletrequest.getParameter("crtby");
            String s27 = httpservletrequest.getParameter("utype");
            String s18 = httpservletrequest.getParameter("topiccount");
            String s29 = httpservletrequest.getParameter("replycount");
            String s20 = httpservletrequest.getParameter("ruser");
            String s22 = httpservletrequest.getParameter("replydate");
            String s24 = httpservletrequest.getParameter("desc");
            String s31 = httpservletrequest.getParameter("sno");
            String s33 = httpservletrequest.getParameter("topicid");
            String s6 = httpservletrequest.getParameter("type");
            String s8 = httpservletrequest.getParameter("topic");
            String s10 = httpservletrequest.getParameter("message");
            String s9 = s10;
            session = httpservletrequest.getSession(false);
            String s = (String)session.getAttribute("emailid");
            String s2 = (String)session.getAttribute("logintype");
            String s7 = s8;
            s7 = s7.replaceAll("\"", "&#34;");
            s7 = s7.replaceAll("'", "&#39;");
            if(s6.equals("3"))
                s7 = "Suggestion";
            FileUtility fu = new FileUtility();
            String s5 = s34 + "/Attachments/";
            File file = new File(s5);
            if(!file.exists())
                file.mkdirs();
            MultipartRequest multipartrequest = new MultipartRequest(httpservletrequest, s5, 0xa00000);
            String s4 = multipartrequest.getFilesystemName("forumattachfile");
            s9 = multipartrequest.getParameter("message");
            s9 = s9.replaceAll("\"", "&#34;");
            s9 = s9.replaceAll("'", "&#39;");
            String s35;
            if(s4 == null)
            {
                s35 = "";
            } else
            {
                s4 = s4.replace('#', '_');
                String s36 = s34 + "/Attachments/" + s;
                fu.createDir(s36);
                s35 = s + "_" + s4;
                fu.renameFile(s5 + "/" + s35, s36 + "/" + s + "_" + s35);
                fu.copyFile(s5 + "/" + s4, s36 + "/" + s + "_" + s4);
                fu.deleteFile(s5 + "/" + s4);
            }
            DbBean dbbean = new DbBean();
            connection = dbbean.getConnection();
            statement = connection.createStatement();
            int i = statement.executeUpdate("insert into forum_post_topic_reply(school_id,forum_id,user_id,trans_type,topic,message,trans_date,forumattachments,topic_id) values('" + s1 + "','" + s3 + "','" + s + "','" + s6 + "','" + s7 + "','" + s9 + "',curdate(),'" + s35 + "','" + s31 + "')");
            if(i == 1)
            {
                if(s2.equals("student"))
                    s2 = "student";
                if(s2.equals("admin"))
                    s2 = "school";
                httpservletresponse.sendRedirect("/LBCOM/" + s2 + "Admin/Forums/ShowReply.jsp?sno=" + s33 + "&sid=" + s1 + "&fid=" + s3 + "&user=" + s14 + "&topic=" + s8 + "&postdate=" + s13 + "&dir=" + s11 + "&crtby=" + s16 + "&utype=" + s27 + "&desc=" + s24 + "&topiccount=" + s18 + "&replycount=" + s29 + "&ruser=" + s20 + "&replydate=" + s22);
            }
        }
        catch(Exception exception)
        {
            ExceptionsFile.postException("StudentReplyForum.java", "service", "Exception", exception.getMessage());
        }
        finally
        {
            try
            {
                if(statement != null)
                    statement.close();
                if(connection != null && !connection.isClosed())
                    connection.close();
            }
            catch(SQLException sqlexception)
            {
                ExceptionsFile.postException("StudentReplyForum.java", "closing connections", "SQLException", sqlexception.getMessage());
            }
        }
    }

    private synchronized String check4Opostrophe(String s)
    {
        StringBuffer stringbuffer = new StringBuffer(s);
        int i = 0;
        int j = 0;
        do
        {
            if(i >= s.length())
                break;
            if(s.charAt(i++) == '\'')
            {
                stringbuffer.replace(j + i, j + i, "'");
                j++;
            }
        } while(true);
        return stringbuffer.toString();
    }

    HttpSession session;
    PrintWriter out;
}
