/*
 * CryptBean.java
 *
 * Created on 20. August 2003, 14:02
 */

package contineo;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


/**
 * This class contains methods to decode and encode string.
 * @author  Michael Scholz
 * @version 1.0
 */
public class CryptBean {
    
    /**
     * This method encodes a given string.
     * @param original String to encode.
     * @return Encoded string.
     */
    public static String cryptString(String original) 
    {
        String copy = "";
        try {
            MessageDigest md = MessageDigest.getInstance("SHA");
            byte digest[] = md.digest(original.getBytes()); 
            for (int i=0; i < digest.length; i++)
                copy += Integer.toHexString(digest[i]&0xFF);    
        }
        catch (NoSuchAlgorithmException nsae) {
            System.out.println("Exception in CryptBean.java is "+nsae);
        }
        return copy;
    }  
    
  
}
