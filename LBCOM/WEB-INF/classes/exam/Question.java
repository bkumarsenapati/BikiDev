package exam;

import java.util.*;

public class Question{


	String bQStr="@@BeginQBody";
	String eQStr="@@EndQBody";
	String bOStr="@@BeginOBody";
	String eOStr="@@EndOBody";
	
	String bLOStr="@@BeginLOBody";				  

	String eLOStr="@@EndLOBody";

	String bROStr="@@BeginROBody";
	String eROStr="@@EndROBody";

//fill in the blanks

	String bAStr="@@BeginABody";
	String eAStr="@@EndABody";

	ArrayList qBody;
	int qType;
	int eNum;

	public void Question(){}	

	public void setQBody(ArrayList qBdy){
		qBody=qBdy;
	}

	public void setQType(int qt){
		qType=qt;
	}



	public ArrayList getQuestionString(){

		int i,j;
		i=0;		

		ArrayList retStr=new ArrayList();

		for(i=1;i<qBody.size();i++){								
			if(qBody.get(i).toString().equals(eQStr))
				break;			
			retStr.add(qBody.get(i));		

		}			
		return retStr;

	}	


	public ArrayList getOptionStrings(){

			ArrayList optBody=readLnQBody(bOStr,eOStr);	
		    return optBody;
	}

	public int getNFields(){
			ArrayList optBody=readLnQBody(bOStr,eOStr);	
			return optBody.size();
	}
/*

	public ArrayList getLOptionStrings(){
			ArrayList optBody=readLnQBody(bLOStr,eLOStr);	
		    return optBody;
	}

	public ArrayList getROptionStrings(){
			ArrayList optBody=readLnQBody(bROStr,eROStr);				
		    return optBody;
	}

*/

public ArrayList getLOptionStrings(){
			ArrayList optBody=readLnLRBody(bLOStr,eLOStr);	
		    return optBody;
	}

	public ArrayList getROptionStrings(){
			ArrayList optBody=readLnLRBody(bROStr,eROStr);				
		    return optBody;
	}


	private ArrayList readLnLRBody(String fromStr,String toStr){
		int i;	
		String temp="";
		ArrayList retStr=new ArrayList();
		i=qBody.indexOf(fromStr);
		i=i+1;
		for(;i<qBody.size();i++){
			if(qBody.get(i).toString().equals(toStr)){
				break;
			}else{
				if(qBody.get(i).toString().indexOf("##")==0){
								if(!temp.equals(""))retStr.add(temp);
								temp="";
								temp=qBody.get(i).toString();
					   }else
								temp=temp+"<BR>"+qBody.get(i);
				} 
		}
		if(!temp.equals(""))retStr.add(temp);
		
		return retStr;
 }

	private ArrayList readLnQBody(String fromStr,String toStr){

		int i;	
		ArrayList retStr=new ArrayList();

		i=qBody.indexOf(fromStr);
		i=i+1;
		for(;i<qBody.size();i++){

			if(qBody.get(i).toString().equals(toStr))
				break;
			retStr.add(qBody.get(i));
		}
		
		return retStr;
   }




}
