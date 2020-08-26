// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 2/6/2012 8:16:43 PM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 

package lbutility;

import coursemgmt.ExceptionsFile;
import java.io.*;

public class Utility
{

    public Utility()
    {
        id = "";
    }

    public Utility(String s)
    {
        id = "";
        cpath = s;
        String s1 = cpath;
        File file = new File(s1);
        if(!file.exists())
            file.mkdirs();
    }

    public synchronized void setNewId(String s, String s1)
        throws IOException
    {
        boolean flag = false;
        String s2 = s + "=" + s1 + "\n";
        try
        {
            RandomAccessFile randomaccessfile = new RandomAccessFile(cpath + "/GenIds.txt", "rw");
            randomaccessfile.seek(0L);
            int i = 0;
            int j = 0;
            for(; (long)i < randomaccessfile.length(); i++)
                if((char)randomaccessfile.readByte() == '\n')
                    j++;

            randomaccessfile.seek(0L);
            for(int k = 1; k <= j; k++)
            {
                String s3 = randomaccessfile.readLine();
                if(s3.indexOf(s) < 0)
                    continue;
                flag = true;
                break;
            }

            if(!flag)
            {
                randomaccessfile.seek(randomaccessfile.length());
                randomaccessfile.writeBytes(s2);
            }
            randomaccessfile.close();
        }
        catch(Exception exception)
        {
            ExceptionsFile.postException("Utility.java", "setNewId", "Exception", exception.getMessage());
        }
    }

    public synchronized String getId(String s)
        throws IOException
    {
        String s4 = "";
        String s5 = "";
        try
        {
            RandomAccessFile randomaccessfile = new RandomAccessFile(cpath + "/GenIds.txt", "rw");
            randomaccessfile.seek(0L);
            int i = 0;
            int k = 0;
            for(; (long)i < randomaccessfile.length(); i++)
                if((char)randomaccessfile.readByte() == '\n')
                    k++;

            randomaccessfile.seek(0L);
            for(int l = 1; l <= k; l++)
            {
                String s1 = randomaccessfile.readLine();
                if(s1.indexOf(s) >= 0)
                {
                    String s3 = s1.substring(s1.indexOf('=') + 1);
                    int i1 = s3.length();
                    int j;
                    for(j = 0; j < s3.length() - 1; j++)
                    {
                        if(s3.charAt(j) >= '0' && s3.charAt(j) <= '9')
                            break;
                        s5 = s5 + s3.charAt(j);
                    }

                    String s2 = s3.substring(j, s3.length());
                    int j1 = Integer.parseInt(s2);
                    int k1 = s3.length() - s5.length();
                    String s6 = s1.substring(0, s1.indexOf('=') + 1) + s5;
                    s4 = writeFile(randomaccessfile, l - 1, s6, j1, k1);
                    s4 = s4.substring(s4.indexOf('=') + 1);
                }
            }

            randomaccessfile.close();
        }
        catch(Exception exception)
        {
            ExceptionsFile.postException("Utility.java", "getNewId", "Exception", exception.getMessage());
        }
        return s4;
    }

    public String writeFile(RandomAccessFile randomaccessfile, int i, String s, int j, int k)
        throws IOException
    {
        String s1 = "";
        int l = 1;
        try
        {
            for(int i1 = ++j; i1 > 0; i1 /= 10)
                l++;

            l--;
            switch(k)
            {
            default:
                break;

            case 9: // '\t'
                switch(l)
                {
                case 1: // '\001'
                    id = s + "00000000" + j;
                    break;

                case 2: // '\002'
                    id = s + "0000000" + j;
                    break;

                case 3: // '\003'
                    id = s + "000000" + j;
                    break;

                case 4: // '\004'
                    id = s + "00000" + j;
                    break;

                case 5: // '\005'
                    id = s + "0000" + j;
                    break;

                case 6: // '\006'
                    id = s + "000" + j;
                    break;

                case 7: // '\007'
                    id = s + "00" + j;
                    break;

                case 8: // '\b'
                    id = s + "0" + j;
                    break;

                case 9: // '\t'
                    id = s + j;
                    break;
                }
                break;

            case 8: // '\b'
                switch(l)
                {
                case 1: // '\001'
                    id = s + "0000000" + j;
                    break;

                case 2: // '\002'
                    id = s + "000000" + j;
                    break;

                case 3: // '\003'
                    id = s + "00000" + j;
                    break;

                case 4: // '\004'
                    id = s + "0000" + j;
                    break;

                case 5: // '\005'
                    id = s + "000" + j;
                    break;

                case 6: // '\006'
                    id = s + "00" + j;
                    break;

                case 7: // '\007'
                    id = s + "0" + j;
                    break;

                case 8: // '\b'
                    id = s + j;
                    break;
                }
                break;

            case 7: // '\007'
                switch(l)
                {
                case 1: // '\001'
                    id = s + "000000" + j;
                    break;

                case 2: // '\002'
                    id = s + "00000" + j;
                    break;

                case 3: // '\003'
                    id = s + "0000" + j;
                    break;

                case 4: // '\004'
                    id = s + "000" + j;
                    break;

                case 5: // '\005'
                    id = s + "00" + j;
                    break;

                case 6: // '\006'
                    id = s + "0" + j;
                    break;

                case 7: // '\007'
                    id = s + j;
                    break;
                }
                break;

            case 6: // '\006'
                switch(l)
                {
                case 1: // '\001'
                    id = s + "00000" + j;
                    break;

                case 2: // '\002'
                    id = s + "0000" + j;
                    break;

                case 3: // '\003'
                    id = s + "000" + j;
                    break;

                case 4: // '\004'
                    id = s + "00" + j;
                    break;

                case 5: // '\005'
                    id = s + "0" + j;
                    break;

                case 6: // '\006'
                    id = s + j;
                    break;
                }
                break;

            case 5: // '\005'
                switch(l)
                {
                case 1: // '\001'
                    id = s + "0000" + j;
                    break;

                case 2: // '\002'
                    id = s + "000" + j;
                    break;

                case 3: // '\003'
                    id = s + "00" + j;
                    break;

                case 4: // '\004'
                    id = s + "0" + j;
                    break;

                case 5: // '\005'
                    id = s + j;
                    break;
                }
                break;

            case 4: // '\004'
                switch(l)
                {
                case 1: // '\001'
                    id = s + "000" + j;
                    break;

                case 2: // '\002'
                    id = s + "00" + j;
                    break;

                case 3: // '\003'
                    id = s + "0" + j;
                    break;

                case 4: // '\004'
                    id = s + j;
                    break;
                }
                break;

            case 3: // '\003'
                switch(l)
                {
                case 1: // '\001'
                    id = s + "00" + j;
                    break;

                case 2: // '\002'
                    id = s + "0" + j;
                    break;

                case 3: // '\003'
                    id = s + j;
                    break;
                }
                break;

            case 2: // '\002'
                switch(l)
                {
                case 1: // '\001'
                    id = s + "0" + j;
                    break;

                case 2: // '\002'
                    id = s + j;
                    break;
                }
                break;

            case 1: // '\001'
                id = s + j;
                break;
            }
            randomaccessfile.seek(0L);
            for(int j1 = 0; j1 < i; j1++)
            {
                String s2 = randomaccessfile.readLine();
            }

            randomaccessfile.writeBytes(id);
        }
        catch(Exception exception)
        {
            ExceptionsFile.postException("Utility.java", "writeFile", "Exception", exception.getMessage());
        }
        return id;
    }

    public static void main(String args[])
        throws IOException
    {
        String s = "";
        Utility utility = new Utility();
        if(args.length > 1)
        {
            utility.setNewId(args[0], args[1]);
            s = utility.getId(args[0]);
        } else
        {
            s = utility.getId(args[0]);
        }
    }

    String id;
    String cpath;
}
