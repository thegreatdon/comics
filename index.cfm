<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
<script language="JavaScript">
function doCmx(cmxurl){
document.getElementById('cmxfrm').src=cmxurl;
}
</script>
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">


<cfform name="cmcfrm">
<cfinput type="text" name="str">
<!--- <cfinput type="button" name="srchbut" bind="{str@keyup}"> --->
</cfform>
<!--- width:300px; --->
<cfdiv bind="url:txtsrch.cfm?str={str@change}" style="overflow:scroll;height:600px;width:600px;float:left;"/>
<!--- 
<div style="float:right;margin-right:15px;">
<a href="javascript:doCmx('http://hankscorpio.info/comics/browse');">hankscorpio</a> | <a href="javascript:doCmx('http://mycomicpost.com/');">mycomicpost</a> | <a href="http://we-comical.blogspot.co.uk/" target="_blank">comical</a><br/>
<iframe id="cmxfrm" style="width:700px;height:600px;"></iframe>
</div>
 --->
</body>
</html>
