<HTML>
<HEAD>
<script language="javascript">

    <!--
      function validateForm()
      {
        if (document.entryForm.yourname.value=="")
        {
          alert("You haven't entered your name !");
          return false;
        }

        document.entryForm.submit();
        return true;
      }
  // -->

</script>
</HEAD>
<BODY>

<FORM METHOD=POST ACTION="/LBCOM/cookie.MyNameServlet" NAME="entryForm">
<INPUT TYPE="TEXT" SIZE="30" NAME="yourname">
<INPUT TYPE="BUTTON" VALUE="  Submit  " OnClick="validateForm()">
</FORM>

</BODY>
</HTML>
