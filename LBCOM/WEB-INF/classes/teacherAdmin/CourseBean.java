package teacherAdmin;

import java.util.Vector;
import java.util.Hashtable;

public class CourseBean  
{   
	private Vector states;
	private Vector grades;
	private Hashtable topics;
	private Hashtable subtopics;
	private Hashtable subjects;

	public CourseBean(){
		states	  =new Vector(2,2);
		grades    =new Vector(2,2);
		topics    =new Hashtable();
		subtopics =new Hashtable();
		subjects  =new Hashtable();
	}
	
	public Vector getStates(){
		return this.states;
	}

	public Vector getGrades(){
		return this.grades;
	}

	public Hashtable getTopics(){
		return this.topics;
	}

	public Hashtable getSubtopics(){
		return this.subtopics;
	}
	
	public Hashtable getSubjects(){
		return this.subjects;
	}

	public void setStates(Vector sts){
		this.states=sts;
	}

	public void setGrades(Vector grds){
		this.grades=grds;
	}

	public void setTopics(Hashtable t){
		this.topics=t;
	}

	public void setSubtopics(Hashtable st){
		this.subtopics=st;
	}

	public void setSubjects(Hashtable sub){
		this.subjects=sub;
	}
}
