package gradebook;

public class RecordTwo{
          
           private String ItemName,Marks,MaxMarks,SubDate;
	              	   
	   public void setItemName(String itemname)
           {
	   	ItemName = itemname;
	   }
 
	   public void setSubDate(String subdate)
           {
	   	SubDate = subdate;
	   }
	   
	   public void setMarks(String marks)
           {
	   	Marks = marks;
	   }
	   
	   public void setMaxMarks(String maxmarks)
           {
	   	MaxMarks = maxmarks;
	   }
	   	   
	   public String getItemName()
           {
	    	 return ItemName;
	   }
           
	   public String getSubDate()
           {
	     	return SubDate;
	   }
	   
	   public String getMarks()
           {
	    	 return Marks;
	   }
	   
	   public String getMaxMarks()
           {
	    	 return MaxMarks;
	   }
}

