// Decompiled by Jad v1.5.8d. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ISCalendar1.java
//package teacherAdmin.organizer;

import java.applet.Applet;
import java.applet.AppletContext;
import java.io.*;
import java.awt.*;
import java.net.URL;
import java.util.Date;

public class ISCalendar1 extends Applet
{

    public ISCalendar1()
    {
		System.out.println("constructor");
    }

    public boolean handleEvent(Event event)
    {
		if(event.target == hc.mndValg)
        {
            Date date = hc.getDate();
            int i = date.getMonth() + 1;
            int j = date.getYear() + 1900;
            int k = date.getDate();
            hc.setVisible(true);
            if(k >= 1)
                orgn(k, i, j);
        }
        else
		if(event.target == hc && event.id == 502)
        {
            Date date = hc.getDate();
            int i = date.getMonth() + 1;
            int j = date.getYear() + 1900;
            int k = date.getDate();
            hc.setVisible(true);
            if(k >= 1)
                orgn(k, i, j);
        }
        return super.handleEvent(event);
    }

    public void init()
    {
		
        userid = getParameter("userid");
        bcolor = getParameter("bcolor");
        fcolor = getParameter("fcolor");
        fstyle = getParameter("fstyle");
        setBackground(new Color(25, 66, 99));
        hc = new hCalendar();
        hc.userid = userid;
        //hc.setBounds(0, 0, 180, 180);
		hc.setBounds(100, 0, 180, 280);
        hc.setVisible(true);
	   
        add(hc);
    }

    public void orgn(int i, int j, int k)
    {
        String s = String.valueOf(i);
        String s1 = String.valueOf(j);
        String s2 = String.valueOf(k);
		String urlpath;
		
        try
        {
            //String s3 = "/LBRT/servlet/teacherAdmin.organizer.Organizer1?userid=" + userid + "&bcolor=" + bcolor + "&fcolor=" + fcolor + "&fstyle=" + fstyle + "&dd=" + s + "&mm=" + s1 + "&yy=" + s2;
				
			urlpath=getCodeBase().toString();
			
			urlpath=urlpath.substring(0,urlpath.indexOf('/',7));
			

            String s3 = urlpath+"/LBRT/teacherAdmin.organizer.Organizer1?userid=" + userid + "&bcolor=" + bcolor + "&fcolor=" + fcolor + "&fstyle=" + fstyle + "&dd=" + s + "&mm=" + s1 + "&yy=" + s2;
			//String s3 = "/LBRT/teacherAdmin.organizer.Organizer1?userid=" + userid + "&bcolor=" + bcolor + "&fcolor=" + fcolor + "&fstyle=" + fstyle + "&dd=" + s + "&mm=" + s1 + "&yy=" + s2;
			

            URL url = new URL(s3);
            java.net.URLConnection urlconnection = url.openConnection();
            AppletContext appletcontext = getAppletContext();
            appletcontext.showDocument(url, "org");
        }
        catch(Exception exception) { }
    }

    hSpinControl hspin;
    Panel panel1;
    Point punkt;
    String userid;
    String bcolor;
    String fcolor;
    String fstyle;
    hCalendar hc;
}
