[TYPO3](http://typo3.org) Theme for [BigBlueButton](http://bigbluebutton.org) Conference Server
==================

Introduction
------------

* [TYPO3](http://typo3.org) is a product of the non-profit [TYPO3 Association](http://association.typo3.org). TYPO3 is an enterprise-level Content Management System (CMS). Another product is [FLOW3](http://flow3.typo3.org), a the next-generation PHP framework. All software is licensed under GNU Public License (GPL), though is this theme, too.
* [BigBlueButton](http://bigbluebutton.org) is a web-conferencing software, enabling people to present and communicate through a web application. This includes voice and video conference, screen sharing and session recording. It is developed by BigBlueButton Inc. and licenced under LGPL license.
* Teams allover the TYPO3 community can use BBB to have virtual meetings free of charge. You can find TYPO3's BigBlueButton server on [bigbluebutton.typo3.org](http://bigbluebutton.typo3.org), where this theme is in use.
* This theme does *not* [style the Flash client"](http://code.google.com/p/bigbluebutton/wiki/Branding) providing the conferencing functionality. Instead, this provides an easy-to-use interface for creating and joining conferences. BBB comes with a <tt>bbb-demo</tt> package, showing demos of the provided API. However, this is no usable interface for end users. Instead, work is required to built a usable interface, which result this code is. As TYPO3's vision is "Inspiring people to share", we want to do the same with this work you!


Compatibility
-------------

This code has been created for BBB version 0.72 and was successfully used with at least version 0.80-beta2.


Installation
------------

* Put the contents of this repository into a subdirectory of the <tt>webapps/bigbluebutton/</tt> directory, e.g. <tt>typo3/</tt>. On Debian/Ubuntu, this would usually be located in <tt>/var/lib/tomcat6/</tt> and result in <tt>/var/lib/tomcat6/webapps/bigbluebotton/typo3/</tt>. 
* Copy the <tt>bbb_api_conf.jsp.dist</tt> file to <tt>bbb_api_conf.jsp</tt>.
    - Set <tt>salt</tt> to your BBB's salt value, which can be retrieved using <tt>bbb-conf --salt</tt>. Do not share this with others, if you do not want anybody else to directly use the API. Usually, only your web interface should use the API.
    - Set <tt>BigBlueButtonURL</tt> to the URL of your BigBlueBotton server, e.g. `http://example.org/bigbluebutton/</tt>.
* After restarting Tomcat with <tt>service tomcat6 restart</tt> you should be able to access your new frontend by opening <tt>http://example.org/bigbluebutton/typo3/start.jsp</tt>.
* To make this available under an URL being easiear to remember, modify the <tt>index.html</tt> file in <tt>/var/www/bigbluebutton-default/</tt> and redirect to visitor to the mentioned URL.


Troubleshooting
---------------

* In case of a <tt>NullPointerException</tt> occurs within <tt>getJoinURL()</tt> a few seconds after creating a conference, the frontend theme is probably not able to contact the BBB API. Make sure that your server can reslove the configured <tt>BigBlueButtonURL</tt>.
* Some subdirectories accessible via HTTP are proxied from Nginx to Tomcat, some are not. This can be confusing, when created files are not accessible. Have a look at <tt>/etc/nginx/sites-available/bigbluebutton</tt>, which paths have a <tt>proxy_pass</tt> directive, and which not.
