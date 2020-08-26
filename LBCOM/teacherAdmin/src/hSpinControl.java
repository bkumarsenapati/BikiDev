// Decompiled by Jad v1.5.8d. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ISCalendar1.java
//import teacherAdmin.organizer;
//package teacherAdmin.organizer;
import java.awt.*;

public class hSpinControl extends Panel
{

    hSpinControl()
    {
        up1 = true;
        up2 = true;
        setLayout(null);
        text = new TextField("0");
        text.reshape(0, 0, 40, 20);
        add(text);
        minx = 55;
        miny = 20;
    }

    hSpinControl(int i, int j, int k)
    {
        up1 = true;
        up2 = true;
        setLayout(null);
        text = new TextField(String.valueOf(k));
        text.reshape(0, 0, i - 15, j);
        add(text);
        minx = i;
        miny = j;
    }

    public String getText()
    {
        return text.getText();
    }

    public boolean handleEvent(Event event)
    {
        int i = event.x;
        int j = event.y;
        switch(event.id)
        {
        case 502: // Event.MOUSE_UP
            if(i > minx - 16 && j < miny / 2)
            {
                up1 = true;
                up2 = true;
                text.setText(String.valueOf(Integer.parseInt(text.getText()) + 1));
            } else
            if(i > minx - 16 && j > miny / 2)
            {
                up1 = true;
                up2 = true;
                text.setText(String.valueOf(Integer.parseInt(text.getText()) - 1));
            }
            // fall through

        case 501: // Event.MOUSE_DOWN
            if(i > minx - 16 && j < miny / 2)
            {
                up1 = false;
                up2 = true;
            } else
            if(i > minx - 16 && j > miny / 2)
            {
                up1 = true;
                up2 = false;
            }
            // fall through

        default:
            return super.handleEvent(event);
        }
    }

    public Dimension minimumSize()
    {
        Dimension dimension = new Dimension(minx, miny);
        return dimension;
    }

    public void paint(Graphics g)
    {
        Dimension dimension = size();
        int i = dimension.width;
        int j = dimension.height;
        g.setColor(Color.lightGray);
        g.fill3DRect(i - 15, 0, 15, j / 2, true);
        g.fill3DRect(i - 15, j / 2, 15, j / 2, true);
        g.setColor(Color.black);
        Polygon polygon = new Polygon();
        polygon.addPoint(i - 8, j / 4 - 3);
        polygon.addPoint(i - 3, j / 4 + 3);
        polygon.addPoint(i - 13, j / 4 + 3);
        g.fillPolygon(polygon);
        Polygon polygon1 = new Polygon();
        polygon1.addPoint(i - 8, (3 * j) / 4 + 2);
        polygon1.addPoint(i - 4, (3 * j) / 4 - 3);
        polygon1.addPoint(i - 12, (3 * j) / 4 - 3);
        g.fillPolygon(polygon1);
    }

    public Dimension preferredSize()
    {
        Dimension dimension = size();
        Dimension dimension1 = minimumSize();
        return new Dimension(Math.max(dimension.width, dimension1.width), Math.max(dimension.height, dimension1.height));
    }

    TextField text;
    int minx;
    int miny;
    boolean up1;
    boolean up2;
}
