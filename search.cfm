<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfparam name="str" default="">

<cfif #len(str)#>
<cfsearch collection="comics" name="cmcsrch" type="SIMPLE">

<cfquery name="cmcstr" dbtype="query">
select * from cmcsrch where lower(title) LIKE '%#lcase(str)#%' order by title asc
</cfquery>
<!---  where category LIKE '%#lcase(str)#%' --->
<cfquery name="cats" dbtype="query">
select distinct category from cmcstr order by category asc
</cfquery>

<cfoutput><h3>#str#</h3></cfoutput>

<cfset catList = "">

<cfoutput query="cats">
<cfset catList = "#listAppend(category,catList)#">
</cfoutput>
<ul>
<!--- <cfoutput query="cmcstr"><li>#title#</li></cfoutput> --->
<cfloop index="c" list="#catList#">
<cfquery name="lst" dbtype="query">
select * from cmcstr where category = '#trim(c)#' order by title asc
</cfquery>
<cfif #c# eq "comics">
<cfoutput query="lst"><li>#title# #summary#</li></cfoutput>
<cfelse>
<li><cfoutput>#c# [#lst.recordcount#]</cfoutput>
	
	<cfset numlist="">
	<cfoutput query="lst">
	
	<cfif #find('-',title)# gt 0>
		<cfset numTit = #Replace(title, '#c#-','')#>
	<cfelse>
		<cfset numTit = #Replace(title, '#c# ','')#>
	</cfif>
	
	<cfset numlist="#listAppend(numlist,numtit)#"></cfoutput>
	<ul>
		<li><cfoutput>#numlist#</cfoutput></li>
	</ul>
</li>
</cfif>
</cfloop>
</ul>
<!--- <cfoutput query="cmcstr">
#title# #category#<br/>
</cfoutput> --->


</cfif>


</body>
</html>
