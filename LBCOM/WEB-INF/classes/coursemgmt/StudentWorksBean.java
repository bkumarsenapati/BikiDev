package coursemgmt;
import java.util.Hashtable;
import java.util.Date;
public class StudentWorksBean 
{

	Hashtable latestAssessments;
	Hashtable dueDateAssessments;
	Hashtable assessmentResults;
	Hashtable upcomingAssessments;
	Hashtable assessmentsNames;

	Hashtable latestAssignments;
	Hashtable dueDateAssignments;
	Hashtable assignmentResults;
	Hashtable upcomingAssignments;
	Hashtable assignmentsNames;

	Hashtable latestCourseOutlines;
	Hashtable latestCourseMaterials;

	Hashtable coursesMaterials;
	Hashtable coursesOutlines;

	Hashtable dueDateCourses;
	Hashtable courses;

	Hashtable dueDates;

	Date today;

	public StudentWorksBean(){
		latestAssessments=null;
		dueDateAssessments=null;
		assessmentResults=null;
		upcomingAssessments=null;
		assessmentsNames=null;

		latestAssignments=null;
		dueDateAssignments=null;
		assignmentResults=null;
		upcomingAssignments=null;
		assignmentsNames=null;

		latestCourseOutlines=null;
		latestCourseMaterials=null;
		coursesMaterials=null;
		coursesOutlines=null;

		dueDateCourses=null;
		courses=null;
		
		dueDates=null;

		today=null;
	}

	public void setLatestAssessments(Hashtable lAssessments){
		this.latestAssessments=lAssessments;
	}
	public void setDueDateAssessments(Hashtable ddAssessments){
		this.dueDateAssessments=ddAssessments;
	}
	public void setAssessmentResults(Hashtable assessResult){
		this.assessmentResults=assessResult;
	}
	public void setUpcomingAssessments(Hashtable uAssessments){
		this.upcomingAssessments=uAssessments;
	}
	public void setAssessmentsNames(Hashtable assessments){
		this.assessmentsNames=assessments;
	}

	public void setLatestAssignments(Hashtable lAssignments){
		this.latestAssignments=lAssignments;
	}
	public void setDueDateAssignments(Hashtable ddAssignments){
		this.dueDateAssignments=ddAssignments;
	}
	public void setAssignmentResults(Hashtable asgnResult){
		this.assignmentResults=asgnResult;
	}
	public void setUpcomingAssignments(Hashtable uAsgn){
		this.upcomingAssignments=uAsgn;
	}
	public void setAssignmentsNames(Hashtable assignments){
		this.assignmentsNames=assignments;
	}


	public void setLatestCourseOutlines(Hashtable lCourseOutline){
		this.latestCourseOutlines=lCourseOutline;
	}
	public void setLatestCourseMaterials(Hashtable lCourseMaterial){
		this.latestCourseMaterials=lCourseMaterial;
	}
	public void setCoursesMaterials(Hashtable cMaterials){
		this.coursesMaterials=cMaterials;
	}
	public void setCoursesOutlines(Hashtable cOutlines){
		this.coursesOutlines=cOutlines;
	}
	
	public void setDueDateCourses(Hashtable ddCourses){
		this.dueDateCourses=ddCourses;
	}

	public void setCourses(Hashtable crs){
		this.courses=crs;
	}

	public void setToday(Date tday){
		this.today=tday;
	}

	public void setDueDates(Hashtable dDates){
		this.dueDates=dDates;
	}

	public Hashtable getLatestAssessments(){
		return latestAssessments;
	}
	public Hashtable getDueDateAssessments(){
		return dueDateAssessments;
	}
	public Hashtable getAssessmentResults(){
		return assessmentResults;
	}
	public Hashtable getUpcomingAssessments(){
		return upcomingAssessments;
	}
	public Hashtable getAssessmentsNames(){
		return assessmentsNames;
	}
	
	public Hashtable getLatestAssignments(){
		return latestAssignments;
	}
	public Hashtable getDueDateAssignments(){
		return dueDateAssignments;
	}
	public Hashtable getAssignmentResults(){
		return assignmentResults;
	}
	public Hashtable getUpcomingAssignments(){
		return upcomingAssignments;
	}
	public Hashtable getAssignmentsNames(){
		return assignmentsNames;
	}

	public Hashtable getLatestCourseOutlines(){
		return latestCourseOutlines;
	}
	public Hashtable getLatestCourseMaterials(){
		return latestCourseMaterials;
	}
	
	public Hashtable getCoursesMaterial(){
		return coursesMaterials;
	}

	public Hashtable getCoursesOutlines(){
		return coursesOutlines;
	}

	public Hashtable getDueDateCourses(){
		return dueDateCourses;
	}
	
	public Hashtable getCourses(){
		return courses;
	}

	public Date getToday(){
		return today;
	}

	public Hashtable getDueDates(){
		return dueDates;
	}
}
