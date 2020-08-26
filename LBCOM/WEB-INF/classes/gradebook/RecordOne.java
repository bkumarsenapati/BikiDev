package gradebook;

import java.util.Date;

public class RecordOne{
          
           private String ItemName;
	   private float Marks,MaxMarks;
	   private Date SubDate;
	              	   
	   public void setItemName(String itemname)
           {
	   	ItemName = itemname;
	   }
 
	   public void setSubDate(Date subdate)
           {
	   	SubDate = subdate;
	   }
	   
	   public void setMarks(float marks)
           {
	   	Marks = marks;
	   }
	   
	   public void setMaxMarks(float maxmarks)
           {
	   	MaxMarks = maxmarks;
	   }
	   	   
	   public String getItemName()
           {
	    	 return ItemName;
	   }
           
	   public Date getSubDate()
           {
	     	return SubDate;
	   }
	   
	   public float getMarks()
           {
	    	 return Marks;
	   }
	   
	   public float getMaxMarks()
           {
	    	 return MaxMarks;
	   }
}

