// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/2/2012 12:02:20 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   SaveNewForum.java

package forums;

import com.oreilly.servlet.MultipartRequest;
import coursemgmt.ExceptionsFile;
import java.io.*;
import java.sql.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.*;
import sqlbean.DbBean;
import utility.FileUtility;

public class SaveNewForum extends HttpServlet
{

    public SaveNewForum()
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
            ExceptionsFile.postException("SaveNewForum.java", "init", "Exception", exception.getMessage());
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
        String s27 = "";
        String s29 = "";
        ServletContext servletcontext = getServletContext();
        String s31 = servletcontext.getInitParameter("forum_path");
        try
        {
            httpservletresponse.setContentType("text/html");
            String s1 = httpservletrequest.getParameter("sid");
            String s3 = httpservletrequest.getParameter("fid");
            String s6 = httpservletrequest.getParameter("tid");
            String s7 = httpservletrequest.getParameter("atid");
            System.out.println("topicId, AtopicId are...." + s6 + "," + s7);
            String s12 = httpservletrequest.getParameter("dir");
            String s13 = httpservletrequest.getParameter("auser");
            String s14 = httpservletrequest.getParameter("postdate");
            String s16 = httpservletrequest.getParameter("crtby");
            String s28 = httpservletrequest.getParameter("utype");
            String s18 = httpservletrequest.getParameter("topiccount");
            String s30 = httpservletrequest.getParameter("replycount");
            String s20 = httpservletrequest.getParameter("ruser");
            String s22 = httpservletrequest.getParameter("replydate");
            String s24 = httpservletrequest.getParameter("desc");
            String s26 = httpservletrequest.getParameter("puser");
            String s8 = httpservletrequest.getParameter("type");
            String s10 = httpservletrequest.getParameter("topic");
            String s11 = httpservletrequest.getParameter("message");
            session = httpservletrequest.getSession(false);
            String s = (String)session.getAttribute("emailid");
            String s2 = (String)session.getAttribute("logintype");
            String s9 = s10;
            if(s8.equals("3"))
                s9 = "Suggestion";
            s9 = s9.replaceAll("\"", "&#34;");
            s9 = s9.replaceAll("'", "&#39;");
            FileUtility fu = new FileUtility();
            String s5 = s31 + "/Attachments/";
            File file = new File(s5);
            if(!file.exists())
                file.mkdirs();
            MultipartRequest multipartrequest = new MultipartRequest(httpservletrequest, s5, 0xa00000);
            String s4 = multipartrequest.getFilesystemName("forumattachfile");
            s11 = multipartrequest.getParameter("message");
            s11 = s11.replaceAll("\"", "&#34;");
            s11 = s11.replaceAll("'", "&#39;");
            String s32;
            if(s4 == null)
            {
                s32 = "";
            } else
            {
                s4 = s4.replace('#', '_');
                String s33 = s31 + "/Attachments/" + s;
                fu.createDir(s33);
                s32 = s + "_" + s4;
                fu.renameFile(s5 + "/" + s32, s33 + "/" + s + "_" + s32);
                fu.copyFile(s5 + "/" + s4, s33 + "/" + s + "_" + s4);
                fu.deleteFile(s5 + "/" + s4);
            }
            DbBean dbbean = new DbBean();
            connection = dbbean.getConnection();
            statement = connection.createStatement();
            int i = statement.executeUpdate("insert into forum_post_topic_reply(school_id,forum_id,user_id,trans_type,topic,message,trans_date,forumattachments,topic_id) values('" + s1 + "','" + s3 + "','" + s + "','" + s8 + "','" + s9 + "','" + s11 + "',curdate(),'" + s32 + "','" + s6 + "')");
            if(i == 1)
            {
                if(s2.equals("admin"))
                    s2 = "school";
                else
                if(s2.equals("teacher"))
                    s2 = "teacher";
                if(s7 == null)
                    httpservletresponse.sendRedirect("/LBCOM/" + s2 + "Admin/Forums/ShowReply.jsp?sno=" + s6 + "&fid=" + s3 + "&user=" + s13 + "&topic=" + s10 + "&postdate=" + s14 + "&dir=" + s12 + "&crtby=" + s16 + "&utype=" + s28 + "&desc=" + s24 + "&topiccount=" + s18 + "&replycount=" + s30 + "&ruser=" + s20 + "&replydate=" + s22);
                else
                    httpservletresponse.sendRedirect("/LBCOM/" + s2 + "Admin/Forums/ShowReply.jsp?sno=" + s7 + "&fid=" + s3 + "&user=" + s13 + "&topic=" + s10 + "&postdate=" + s14 + "&dir=" + s12 + "&crtby=" + s16 + "&utype=" + s28 + "&desc=" + s24 + "&topiccount=" + s18 + "&replycount=" + s30 + "&ruser=" + s20 + "&replydate=" + s22);
            }
        }
        catch(Exception exception)
        {
            ExceptionsFile.postException("SaveNewForum.java", "service", "Exception", exception.getMessage());
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
                ExceptionsFile.postException("SaveNewForum.java", "closing connections", "SQLException", sqlexception.getMessage());
            }
            catch(Exception exception2)
            {
                ExceptionsFile.postException("SaveNewForum.java", "service", "Exception", exception2.getMessage());
                System.out.println(exception2);
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
