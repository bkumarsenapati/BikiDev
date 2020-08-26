<%@ include file="/common/checksession.jsp" %> 
<html>
<head>
	<script language="Javascript" src="../JS/mainpage.js"></script>
</head>
<body>
<form method="post" name="newForm" action="#">
<table width="369">
<tr>
	<td width="363"><font face="Arial"><span style="font-size:10pt;">Please enter file name and select the file type to create a file.</span></font><br><br></td>
	</tr>
	<tr>
	<td width="363"><font face="Arial"><span style="font-size:10pt;">File Name <input type="text" name="file_name"></span></font></td>
	</tr>
	<!-- <tr>
	<td width="363"><font face="Arial"><span style="font-size:10pt;"><input type="radio" name="files" id="tt" value="word">&nbsp;&nbsp;&nbsp;Word Document (.doc)</span></font></td>
	</tr> -->
    <tr>
        <td width="363">
            <p><font face="Arial"><span style="font-size:10pt;"><input type="radio" name="files" id="tt" value="text">&nbsp;&nbsp;&nbsp;Text File (.txt)</span></font></p>
        </td>
    </tr>
    <tr>
        <td width="363">
            <p><font face="Arial"><span style="font-size:10pt;"><input type="radio" name="files" id="tt" value="html_file">&nbsp;&nbsp;&nbsp;Html File (.html)</span></font></p>
        </td>
    </tr>
	<tr>
        <td width="363">
            <p align="center"><font face="Arial"><span style="font-size:10pt;">
	<input type="button" value="Create File" style="width: 70pt;" onclick="return createFile();">&nbsp;&nbsp;&nbsp;
	<input type="button" name="cancel" value="Back" style="width: 70pt;" onclick="back()"></span></font></p>
        </td>
	</tr>

</table>
<!--<table>
	<tr>
	<td>File Name :<input type="text" name="file_name" ></td>
	</tr>
	<tr>
	<td><input type="radio" name="files" id="tt" value="word">&nbsp;&nbsp;&nbsp;Word File</td>
	</tr>
	<tr>
	<td><input type="radio" name="files" id="tt" value="text">&nbsp;&nbsp;&nbsp;Text File</td>
	</tr>
	<tr>
	<td><input type="radio" name="files" id="tt" value="html_file">&nbsp;&nbsp;&nbsp;Html File</td>
	</tr>
	<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="CreateFile" onclick="return createFile();">&nbsp;&nbsp;&nbsp;
	<input type="button" name="cancel" value="Cancel" onclick="back()"></td>
	</tr>

</table>-->
</form>
</body>