// Decompiled by Jad v1.5.8d. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ISCalendar1.java
//package teacherAdmin.organizer;
import java.awt.*;
import java.util.Date;

public class hCalendar extends Panel
{

    hCalendar()
    {
        setLayout(null);
        dato = new Date();
        panel1 = new Panel();
        panel1.reshape(3, 3, 174, 40);
        add(panel1);
        mndValg = new Choice();
        mndValg.addItem("January");
        mndValg.addItem("February");
        mndValg.addItem("March");
        mndValg.addItem("April");
        mndValg.addItem("May");
        mndValg.addItem("June");
        mndValg.addItem("July");
        mndValg.addItem("August");
        mndValg.addItem("September");
        mndValg.addItem("October");
        mndValg.addItem("November");
        mndValg.addItem("December");
        panel1.add(mndValg);
        mndValg.select(dato.getMonth());
        hspin = new hSpinControl(60, 20, dato.getYear() + 1900);
        panel1.add(hspin);
        calM = new int[54];
        setFont(new Font("Helvetica", 1, 10));
        setBackground(Color.lightGray);
		
        drawCalendar(dato);
    }

    public void drawCalendar(Date date)
    {
        int i = date.getMonth();
        int j = date.getYear();
        int k = 29;
        Date date1 = new Date(j, i, 1);
        int l = date1.getDay() + 5;
        if(l == 5)
            l = 12;
        if(i == 1)
        {
            if(isLeapyear(j + 1900))
                k = 30;
        } else
        {
            k = DaysInMonth[i] + 1;
        }
        for(int i1 = 0; i1 < 54; i1++)
            calM[i1] = 0;

        for(int j1 = l; j1 < k + l; j1++)
            calM[j1] = j1 - l;

        repaint();
    }

    public Date getDate()
    {
        return dato;
    }

    public boolean handleEvent(Event event)
    {
        switch(event.id)
        {
        case 502: // Event.MOUSE_UP
            if(event.x > 6 && event.x < 174 && event.y > 35 && event.y < 172)
            {
                int i = 0;
                for(int l = 0; l <= 6; l++)
                {
                    for(int k1 = 1; k1 <= 7; k1++)
                    {
                        if(calM[i] > 0 && event.x > k1 * 24 - 18 && event.x < k1 * 24 + 5 && event.y > 35 + l * 20 && event.y < 54 + l * 20)
                        {
                            dato = new Date(dato.getYear(), dato.getMonth(), calM[i]);
                            panel1.setCursor(new Cursor(3));
                            panel1.setCursor(new Cursor(0));
                            drawCalendar(dato);
                        }
                        i++;
                    }

                }

            } else
            if(event.target == hspin)
            {
                int j = Integer.parseInt(hspin.getText()) - 1900;
                int i1 = dato.getMonth();
                int l1 = dato.getDate();
                if(j > 70 && j < 137)
                {
                    dato = new Date(j, i1, l1);
                    drawCalendar(dato);
                }
            }
            // fall through

        case 1001: // Event.ACTION_EVENT
            if(event.target == mndValg)
            {
                int k = dato.getYear();
                int j1 = mndValg.getSelectedIndex();
                int i2 = dato.getDate();
                dato = new Date(k, j1, i2);
                drawCalendar(dato);
            }
            // fall through

        default:
            return super.handleEvent(event);
        }
    }

    public boolean isLeapyear(int i)
    {
        if(i % 100 == 0)
            return i % 400 == 0;
        else
            return i % 4 == 0;
    }

    public void paint(Graphics g1)
    {
        Dimension dimension = size();
        int i = dimension.width;
        int j = dimension.height;
        int k = 0;
        for(int l = 0; l <= 6; l++)
        {
            for(int i1 = 1; i1 <= 7; i1++)
            {
                if(calM[k] > 0)
                {
                    if(i1 == 7)
                    {
                        g1.setColor(new Color(204, 51, 0));
                        g1.draw3DRect(i1 * 24 - 18, 35 + l * 20, 23, 19, true);
                        g1.fillRect(i1 * 24 - 18, 35 + l * 20, 23, 19);
                        g1.setColor(Color.white);
                        if(calM[k] > 9)
                            g1.drawString(String.valueOf(calM[k]), i1 * 24 - 11, 49 + l * 20);
                        else
                            g1.drawString(" " + String.valueOf(calM[k]), i1 * 24 - 11, 49 + l * 20);
                    }
                    if(calM[k] == dato.getDate())
                    {
                        g1.setColor(new Color(200, 255, 200));
                        g1.fillRect(i1 * 24 - 18, 35 + l * 20, 23, 19);
                        g1.setColor(Color.blue);
                        if(calM[k] > 9)
                            g1.drawString(String.valueOf(calM[k]), i1 * 24 - 11, 49 + l * 20);
                        else
                            g1.drawString(" " + String.valueOf(calM[k]), i1 * 24 - 11, 49 + l * 20);
                    }
                    if(i1 != 7)
                    {
                        g1.setColor(Color.lightGray);
                        g1.draw3DRect(i1 * 24 - 18, 35 + l * 20, 23, 19, true);
                        g1.setColor(Color.black);
                        if(calM[k] > 9)
                            g1.drawString(String.valueOf(calM[k]), i1 * 24 - 11, 49 + l * 20);
                        else
                            g1.drawString(" " + String.valueOf(calM[k]), i1 * 24 - 11, 49 + l * 20);
                    }
                }
                k++;
            }

        }

        g1.setColor(Color.black);
        g1.drawString("mo", 13, 50);
        g1.drawString("tu", 40, 50);
        g1.drawString("we", 62, 50);
        g1.drawString("th", 86, 50);
        g1.drawString("fr", 110, 50);
        g1.drawString("sa", 134, 50);
        g1.drawString("su", 158, 50);
    }

    int calM[];
    Date dato;
    Choice mndValg;
    TextField aar;
    hSpinControl hspin;
    Graphics g;
    Panel panel1;
    String userid;
    static final int rows = 6;
    static final int cols = 7;
    int DaysInMonth[] = {
        31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 
        30, 31
    };
}
