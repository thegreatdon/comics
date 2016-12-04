<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfscript>
function ListDeleteDuplicates(list) {
  var i = 1;
  var delimiter = '|';
  var returnValue = '';
  if(ArrayLen(arguments) GTE 2)
    delimiter = arguments[2];
  list = ListToArray(list, delimiter);
  for(i = 1; i LTE ArrayLen(list); i = i + 1)
    if(NOT ListFind(returnValue, list[i], delimiter))
      returnValue = ListAppend(returnValue, list[i], delimiter);
  return returnValue;
}
</cfscript>

<html>
<head>
	<title>Untitled</title>
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
<cfparam name="str" default="">
<cfoutput></cfoutput>
<cfif #len(str)#>
<cfset str = #lcase(str)#>
<cffile action="READ" file="#expandPath('.')#\cmx.txt" variable="cmx">

<cfset cmxArr = #listToArray(cmx,":")#>
<!--- <cfset str = "bat"> --->
<cfoutput>

<cfset unqFldLst = "">
<cfset rcnt=0>


<cfset cmxDb = QueryNew("id,title,folder,pth")>
<!--- Make two rows in the query --->
<!--- <cfset newRow = QueryAddRow(MyQuery, 2)> --->



<cfloop index="c" from="1" to="#arrayLen(cmxArr)#" step="1">
<cfset nmeArr = "#listToArray(cmxArr[c],'\')#">

<cfset strtitle=#lcase(cmxArr[c])#>
<cfset hascbr = #find('.cbr',strtitle)#>
<cfset hascbz = #find('.cbz',strtitle)#>

<cfset filnme= "#nmeArr[arrayLen(nmeArr)]#">
<cfset stPos = #evaluate(len(filnme)-2)#>
<cfif #find(".",filnme)# gt 0>
<cfset getNme = #trim(mid(filnme,1,stPos))#>


<cfif #hascbr# gt 0>
	<cfset stpNme = #find('.cbr',filnme)#>
<cfelse>
	<cfset stpNme = #find('.cbz',filnme)#>
</cfif>
<cfif #stpNme# gt 0>
	<cfset stpNme = #evaluate(stpNme-1)#>
</cfif>

<cfset title=#mid(filnme,1,stpNme)#>

<!--- 
<cfset getNmeArr = #listToArray(getNme,".")#>
<cfset title=#getNmeArr[1]#>
 --->
<!--- <cfset strtitle=#lcase(getNmeArr[1])#> --->





<cfif #find(str,strtitle)# gt 0>

<cfif #hascbr# gt 0 or #hascbz# gt 0>

<cfset rcnt=#evaluate(rcnt+1)#>


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
	<cfif #listFind(unqFldLst,trim(cat))# eq 0 and cat neq "Comics">
	<cfset unqFldLst = "#listAppend(unqFldLst,cat,'|')#">
	</cfif>
	<cfsavecontent variable="upth">Comics<cfif #arrayLen(nmeArr)# gt 2>\#nmeArr[2]#<cfif #arrayLen(nmeArr)# gt 3>\#nmeArr[3]#</cfif><cfif #arrayLen(nmeArr)# gt 4>\#nmeArr[4]#</cfif></cfif></cfsavecontent>


<cfset newRow = QueryAddRow(cmxDb, 1)>
<!--- Set the values of the cells in the query --->
<cfset temp = QuerySetCell(cmxDb, "id", "#rcnt#", #rcnt#)>
<cfset temp = QuerySetCell(cmxDb, "title", "#title#", #rcnt#)>
<cfset temp = QuerySetCell(cmxDb, "folder", "#cat#", #rcnt#)>
<cfset temp = QuerySetCell(cmxDb, "pth", "#upth#", #rcnt#)>

<!--- 
<div style="margin-bottom:15px;">
#cmxArr[c]#<br/>
#rcnt# #title#<br/>
</div>
 --->
	<!--- <cfsavecontent variable="upth">#find(str,strtitle)#Comics<cfif #arrayLen(nmeArr)# gt 2>\#nmeArr[2]#<cfif #arrayLen(nmeArr)# gt 3>\#nmeArr[3]#</cfif><cfif #arrayLen(nmeArr)# gt 4>\#nmeArr[4]#</cfif></cfif></cfsavecontent>
	&lt;cfindex action="UPDATE" type="CUSTOM" collection="comics" key="#c#" title="#strtitle#" urlpath="#upth#" category="#cat#" custom1="#cst1#" custom2="#cst2#" body="#upth#"&gt; --->
</cfif>
</cfif>
</cfif>
</cfloop>

<cfset unqFldLst = #ListDeleteDuplicates(unqFldLst)#>
<!--- #unqFldLst# --->

</cfoutput>
<!--- <cfdump var=#cmxDb#> --->
<!--- id,title,folder,pth --->
<!--- <cfquery name="cmxFld" dbtype="query">
select distinct folder from cmxDb order by folder asc
</cfquery> --->
<cfquery name="noFld" dbtype="query">
select id,title,folder,pth from cmxDb 
where folder =  'Comics'
order by title asc
</cfquery>

<ul style="margin-left:-10px;font-size:11px;font-family:verdana;">
<cfoutput query="noFld"><li>#title#</li></cfoutput>
<cfloop index="f" list="#unqFldLst#" delimiters="|">
<li><cfoutput>#f#</cfoutput>
<cfquery name="cmxFld" dbtype="query">
select id,title,folder,pth from cmxDb 
where folder = '#f#'
order by title asc
</cfquery>
	<ul><li>
	<cfoutput query="cmxFld">
	<cfif #len(title)#>
	<cfset fixTitle = #Replace(title,'#trim(folder)# ','')#>
	<cfset fixTitle = #Replace(fixTitle,'#fixTitle#-','')#>
	<cfset fixTitle = #Replace(fixTitle,'#fixTitle# - ','')#>
	#fixTitle#<cfif #currentrow# lt #recordcount#>, </cfif>
	</cfif></cfoutput>
	</ul></li>
</li>
</cfloop>
</ul>

</cfif>
</body>
</html>
