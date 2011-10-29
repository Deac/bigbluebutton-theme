<%
/*
/***************************************************************
 *  Copyright notice
 *
 *  (c) 2011 Susanne Moog <susanne.moog@typo3.org>
 *           Steffen Gebert <steffen.gebert@typo3.org>
 *  All rights reserved
 *
 *  This script is part of the TYPO3 project. The TYPO3 project is
 *  free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  The GNU General Public License can be found at
 *  http://www.gnu.org/copyleft/gpl.html.
 *
 *  This script is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  This copyright notice MUST APPEAR in all copies of the script!
 ****************************************************************
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	response.setCharacterEncoding("UTF-8"); 
%>

<%@page import="org.w3c.dom.*"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Big Blue Button for TYPO3</title>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script type="text/javascript" src="start.js"></script>
<script src="md5.js"></script>
<script type="text/javascript" src="jquery.xml2json.js"></script>
<link rel="stylesheet" href="share/stylesheet.css" />
<link rel="stylesheet" href="css/index.css" />
</head>
<body>

<%@ include file="bbb_api.jsp"%>

<div id="header">
<img src="images/logo-typo3.gif" alt="TYPO3 Logo" />
<span id="claim">Big Blue Button</span>
</div>

<%
if (request.getParameterMap().isEmpty()) {
%>
<div id="activeMeetings">
	<h2>Currently Active Meetings</h2>

	<p id="no_meetings"></p>

	<div id="meetings"></div>
</div>
<div id="createMeetingForm">
	<h2>Create Your Own Meeting</h2>

	<p />
	<form name="form1" target="_parent" method="get">
		Create your own meeting.
		<p />
		Enter your name:<br />
		<input type="text" name="username" /><br />
		Enter a name for your meeting:<br />
		<input type="text" name="meetingID" /><br />
		<input type="hidden" name="action" value="create">
		<input type="hidden" name="state" value="new">
		<input id="submit-button" type="submit" value="Create meeting" />
	</form>
</div>

<% 
} else if (request.getParameter("action").equals("create")) {
	String username = request.getParameter("username");
	String meetingID = request.getParameter("meetingID");
	String state = request.getParameter("state");

	if (state != null) {
	    if (state.equals("new")) {
		String inviteURL = BigBlueButtonURL	+ "typo3/start.jsp?action=invite&meetingID=" + URLEncoder.encode(meetingID, "UTF-8");
		%>
		<div id="invitation">
				<h2>Invite Others</h2>
				<p>
					Others can join your meeting by calling the following URL in their browser: <br />
					<a href="<%=inviteURL%>"><%=inviteURL%></a>

					<form name="form1" target="_parent" method="get">
						<input type="hidden" name="username" value="<%=StringEscapeUtils.escapeHtml(username)%>" />
						<input type="hidden" name="meetingID" value="<%=StringEscapeUtils.escapeHtml(meetingID)%>" />
						<input type=hidden name=action value="create">
						<input id="submit-button" type="submit" value="Go to your meeting" />
					</form>
				</p>
		</div>
		<% 
		}
	} else {
		String joinURL = getJoinURL(request.getParameter("username"), request.getParameter("meetingID"), "Welcome to " + request.getParameter("meetingID"), "mp");
		if (joinURL.startsWith("http://")) { 
			%>
			<script language="javascript" type="text/javascript">
				window.location.href="<%=joinURL%>";
			</script>

		<% } else { %>
			Error: getJoinURL() failed
			<p/>
			<%=joinURL %>
		<% 
		}
	}

} else if (request.getParameter("action").equals("invite")) {
		String meetingIDInvitation = request.getParameter("meetingID");
	%>
	<div id="joinAMeeting">
		<h2>Join "<%=StringEscapeUtils.escapeHtml(meetingIDInvitation)%>"</h2>
		<p>
			<form name="form1" METHOD="GET">
				Choose a username:<br />
				<input type="text" name="username" />
				<input type="hidden" name="meetingID" value="<%=StringEscapeUtils.escapeHtml(meetingIDInvitation)%>" />
				<input type="hidden" name="action" value="join" />
				<input id="submit-button" type="submit" value="Join" />
			</form>
		</p>
	</div>
<%
} else if (request.getParameter("action").equals("join")) {
		String joinURL = getJoinURL(request.getParameter("username"), request.getParameter("meetingID"), "Welcome to " + request.getParameter("meetingID"), "ap");
		if (joinURL.startsWith("http://")) { 
		%>
		<script language="javascript" type="text/javascript">
			window.location.href="<%=joinURL%>";
		</script>

		<% } else { %>

		Error: getJoinURL() failed
		<p/>
		<%=joinURL %>

		<% 
		}
	}

%>

</body>
</html>