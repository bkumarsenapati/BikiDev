<%@ page import="java.io.*,org.apache.poi.hwpf.extractor.*"%>
<%@page import="org.apache.poi.poifs.filesystem.*,org.apache.poi.hwpf.*"%>
<%@page import="com.lowagie.text.rtf.*,javax.swing.text.*"%>
<%@page import="com.lowagie.text.*,javax.swing.text.rtf.RTFEditorKit"%>
<%@ page import="java.sql.*"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 


<%!
			private String f_name="",plainText="";
			private File text_path=null;
			private FileInputStream fis=null;
			POIFSFileSystem fs = null;
			private FileReader fr=null;
			private BufferedReader br=null;
%>
<%
		f_name=request.getParameter("f_name");
		try{
		 text_path=new File(f_name);
		fis=new FileInputStream(text_path.getAbsolutePath());

		if(text_path.getName().substring(text_path.getName().lastIndexOf('.')+1).equals("doc"))
		{
			fs = new POIFSFileSystem(fis);
			HWPFDocument doc = new HWPFDocument(fs);
			
		  WordExtractor we = new WordExtractor(doc);
		  
		
		  String[] paragraphs = we.getParagraphText();
			
		  for( int m=0; m<paragraphs .length; m++ ) {
			paragraphs[m] = paragraphs[m].replaceAll("\\cM?\r?\n","");
			//if(paragraphs[m] != null)
				plainText=plainText+"<br>"+paragraphs[m];
			}
	
			//plainText=we.getText();
			
			
			f_name=f_name.substring(0,f_name.lastIndexOf("/"));
			
			String fn=text_path.getName().substring(0,text_path.getName().lastIndexOf('.'));
			
			//String extt=fn.substring(fn.lastIndexOf('.');
			
			f_name=f_name+"/"+fn+".rtf";
			
			//session.setAttribute("upfilename",text_path.getPath());

		  }else if(text_path.getName().substring(text_path.getName().lastIndexOf('.')+1).equals("rtf"))
			{
			//
			RTFEditorKit kit = new RTFEditorKit();
			javax.swing.text.Document doc = kit.createDefaultDocument();
			kit.read(fis, doc, 0);
			plainText = doc.getText(0, doc.getLength());			
			}
			
			//String temp=plainText.replaceAll("<?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" />","");<?xml:namespace prefix = st1 ns = "urn:schemas-microsoft-com:office:smarttags" />
			String temp=plainText.replaceAll("<?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" />"," ");
			temp=temp.replaceAll("<?xml:namespace prefix = v ns = \"urn:schemas-microsoft-com:vml\" />"," ");
			temp=temp.replaceAll("<?xml:namespace prefix = st1 ns = \"urn:schemas-microsoft-com:office:smarttags\" />"," ");
			temp=temp.replaceAll("\\?"," ");
			out.println(temp);
		}catch(Exception exp)
		{
			exp.printStackTrace();
		}
		finally
	{
		try{
			
			if(fis!=null)
			fis.close();
		
		}catch(Exception exp)
		{exp.printStackTrace();}
	}
%>