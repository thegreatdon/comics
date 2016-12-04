<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfparam name="str" default="">

<cfif #len(str)#>
<cffile action="READ" file="C:\ColdFusion9\wwwroot\comics\cmx021413.txt" variable="cmx">

<cfset cmxArr = #listToArray(cmx,":")#>
<!--- <cfset str = "bat"> --->
<cfoutput>



<cfloop index="c" from="2" to="#arrayLen(cmxArr)#" step="1">
<cfset nmeArr = "#listToArray(cmxArr[c],'\')#">

<cfset filnme= "#nmeArr[arrayLen(nmeArr)]#">
<cfset stPos = #evaluate(len(filnme)-2)#>
<cfif #find(".",filnme)# gt 0>
<cfset getNme = #trim(mid(filnme,1,stPos))#>
<cfset getNmeArr = #listToArray(getNme,".")#>

<cfset strtitle=#lcase(getNmeArr[1])#>
<cfset title=#getNmeArr[1]#>
<cfif #find(str,strtitle)# gt 0>
<div style="margin-bottom:15px;">
<cfset cat = "Comics">
<cfif #arrayLen(nmeArr)# gt 2>
	<cfset cat = "#trim(nmeArr[2])#">
</cfif>
<cfset cst1 = "">
<cfif #arrayLen(nmeArr)# gt 3>
	<cfset cst1 = "#trim(nmeArr[3])#">
</cfif>
<cfset cst2 = "">
<cfif #arrayLen(nmeArr)# gt 4>
	<cfset cst2 = "#trim(nmeArr[4])#">
</cfif>
#title#
<!--- <cfsavecontent variable="upth">#find(str,strtitle)#Comics<cfif #arrayLen(nmeArr)# gt 2>\#nmeArr[2]#<cfif #arrayLen(nmeArr)# gt 3>\#nmeArr[3]#</cfif><cfif #arrayLen(nmeArr)# gt 4>\#nmeArr[4]#</cfif></cfif></cfsavecontent>
&lt;cfindex action="UPDATE" type="CUSTOM" collection="comics" key="#c#" title="#strtitle#" urlpath="#upth#" category="#cat#" custom1="#cst1#" custom2="#cst2#" body="#upth#"&gt; --->
</div>
</cfif>
</cfif>
</cfloop>

</cfoutput>

</cfif>
</body>
</html>
