package contineo;

public class  DataBean
{
	private String username;
	private String schoolid;
	private String password;
	private String fname;
	private String lname;
	private String language;
	private String group;
	private String email;
	private String type;
	private String groupParent;

	public DataBean(){
		username="";
		schoolid="";
		password="";
		fname="";
		lname="";
		language="en";
		group="";
		email="";
		type="";
		groupParent="author";
	}

	public void setUsername(String uname){
		this.username=uname;
	}
	public void setSchoolid(String school){
		this.schoolid=school;
	}
	public void setPassword(String pwd){
		this.password=pwd;
	}
	public void setFname(String fName){
		this.fname=fName;
	}
	public void setLname(String lName){
		this.lname=lName;
	}
	public void setLanguage(String lan){
		this.language=lan;
	}
	public void setGroup(String grp){
		
		this.group=grp;
	}
	public void setEmail(String mail){
		this.email=mail;
	}
	public void setType(String typ){
		this.type=typ;
	}
	public void setGroupParent(String grpParent){
		this.groupParent=grpParent;
	}


	public String getUsername(){
		return (username);
	}

	public String getSchoolid(){
		return (schoolid);
	}

	public String getPassword(){
		return (password);
	}

	public String getFname(){
		return (fname);
	}

	public String getLname(){
		return (lname);
	}

	public String getLanguage(){
		return (language);
	}

	public String getGroup(){
		return (group);
	}
	
	public String getEmail(){
		return (email);
	}
	public String getType(){
		return (type);
	}
	public String getGroupParent(){
		return (groupParent);

	}
	
	public void reset(){
		username="";
		schoolid="";
		password="";
		fname="";
		lname="";
		language="en";
		group="";
		email="";
		type="";
		groupParent="author";
	}
}
