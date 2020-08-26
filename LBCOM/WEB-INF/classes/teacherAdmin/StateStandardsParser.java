package teacherAdmin;

import java.io.*;
import java.util.Vector;
import java.util.*;
import java.util.Enumeration;
import java.util.Hashtable;
import teacherAdmin.CourseBean;
import coursemgmt.ExceptionsFile;

import java.net.URL;
import org.jdom.Document;
import org.jdom.Attribute;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;
import org.jdom.JDOMException;

public class  StateStandardsParser 
{
	private Document doc;
	private Element root;
	private String docPath;
	private Vector grades;
	private Hashtable subjects;
	private Hashtable topics;
	private Hashtable subtopics;
	private CourseBean coursebean;

	public StateStandardsParser(URL path){
		//File f=new File(path);
		docPath=path.getFile();
		initDocument();

	}
	public StateStandardsParser(String path){
		//File f=new File(path);
		docPath=path;

		grades=new Vector(2,2);
		subjects=new Hashtable();
		topics=new Hashtable();
		subtopics=new Hashtable();

		coursebean=new CourseBean();
		initDocument();

	}

	public void initDocument(){
		try{

			SAXBuilder sax=new SAXBuilder();

			File f=new File(docPath);
			doc=sax.build(f);

			root=doc.getRootElement();

		}catch(JDOMException jd){
			ExceptionsFile.postException("StateStandardsParser.java","initDocument","JDOMException",jd.getMessage());
			
		}

	}

	public Element getRootElement(){
		return root;
	}
	public Vector getChildAttributes(String eleName,String attrName){
		Vector attr=new Vector(2,2);
		try{
			List elements=root.getChildren(eleName);
			Iterator ite=elements.iterator();
			Element e=null;
			
			while(ite.hasNext()){
				e=(Element)ite.next();
				attr.add(e.getAttributeValue(attrName));
			}
		}catch(Exception e){
			ExceptionsFile.postException("StateStandardsParser.java","getChildAttribute","Exception",e.getMessage());
			
		}
		return attr;
	}

	public String getElementText(String eleName,String attrName,String attrValue){
		String elementText="";
		try{
			
			List elements=root.getChildren(eleName);
			
			Iterator ite=elements.iterator();
			
			Element e=null;
			
			
			
			while(ite.hasNext()){
				
				e=(Element)ite.next();
				
				if(e.getAttributeValue(attrName).equals(attrValue)){
					
					elementText=e.getText();
					
				}
			}
		}catch(Exception e){
			ExceptionsFile.postException("StateStandardsParser.java","getElementText","Exception",e.getMessage());
			
		}
		return elementText;
	}

	public String getElementText(String level1ele,String level2ele,String level3ele,String id1,String id2){
		String elementText="";
		try{
			
			List elements=root.getChildren(level1ele);
			
			Iterator ite=elements.iterator();
			
			Element e=null;
			
			
			
			while(ite.hasNext()){
				
				e=(Element)ite.next();
				
				if(e.getAttributeValue("id").equals(id1)){
					
					elements=e.getChildren(level2ele);
					
					break;
				}
			}
			ite=elements.iterator();
			while(ite.hasNext()){
				e=(Element)ite.next();
				if(e.getAttributeValue("id").equals(id2)){
					elementText=e.getChildText(level3ele);
					break;
				}
			}
		}catch(Exception e){
			ExceptionsFile.postException("StateStandardsParser.java","getElementText","Exception",e.getMessage());
			
		}
		return elementText;
	}
	public CourseBean getAllChildElementsText(){
		try{
			List sub=null;
			ListIterator enumm,enum1;
			Element e=null;
			String grade="";
			String subject="";
			enumm=(root.getChildren()).listIterator();
			while(enumm.hasNext()){
				e=(Element)enumm.next();
				grade=e.getAttributeValue("id");
				grades.add(grade);
				sub=e.getChildren("subject");
				enum1=sub.listIterator();

				while(enum1.hasNext()){
					e=(Element)enum1.next();
					subject=e.getAttributeValue("id");
					subjects.put(grade+"@"+subject,subject);
					topics.put(grade+"@"+subject,e.getChildText("topic"));
					subtopics.put(grade+"@"+subject,e.getChildText("subtopic"));
					
					
					
					
				}
				
				
			//	e.setAttribute("id",grade+"Ramesh");

			}
			//writeXMLDoc();    
			coursebean.setGrades(grades);
			coursebean.setSubjects(subjects);
			coursebean.setTopics(topics);
			coursebean.setSubtopics(subtopics);
		}catch(Exception e){
			ExceptionsFile.postException("StateStandardsParser.java","getAllChildElementsText","Exception",e.getMessage());
			
		}
		return coursebean;
		
	}
	
	public void writeXMLDoc() {
        boolean result = true;
        try { 
			//Format.setExpandEmptyElements(true);
            XMLOutputter outputter = new XMLOutputter(docPath);
            File file = new File(docPath);                  
            OutputStream out = new FileOutputStream(file);
            outputter.output(doc,out);
            out.close();
        }
        catch (Exception ex) {
			ExceptionsFile.postException("StateStandardsParser.java","writeXMLDoc","Exception",ex.getMessage());
            result = false;
          
        }
        //return result;
    }

	public boolean CheckFile(String path){
		boolean result=false;
		try{
			File f=new File(path);
			if(f.exists()&& f.isFile()){
				result=true;
			}else 
				result=false;
		}catch(Exception e){
			ExceptionsFile.postException("StateStandardsParser.java","CheckFile","Exception",e.getMessage());
			
		}
		return result;
	}
	/*public static void main(String args[]){
		try{
			//StateStandardsParser ssp=new StateStandardsParser(StateStandardsParser.class.getResource("C:/California.xml"));
			StateStandardsParser ssp=new StateStandardsParser("C:/California.xml");
			ssp.setAllChildElementsText();

		}catch(Exception e){
			
		}

	}*/

	
}
