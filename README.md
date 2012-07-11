<h1>seemore.js</h1>

<p>A lightweight, simple jQuery plugin for partial collapse and expand of html.</p>

<p>To use seemore.js, include jQuery and the seemore.js javascript source file in your html page with <pre>&lt;script type='text/javascript' src='jquery.min.js'&gt;&lt;/script&gt;
&lt;script type='text/javascript' src='seemore.js'&gt;&lt;/script&gt;</pre>Wrap your partially collapsable html in an element with class 'seemore', the part you would like hidden by default in an element with class 'seemore-more', and your toggle links in an element with class 'seemore-link' as such:</p>
<pre>&lt;p class='seemore'&gt;Lorem ipsum dolor sit amet, consectetur adipisicing elit,
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam
&lt;span class='seemore-link'&gt;... &lt;a href='#'&gt;(more)&lt;/a&gt;&lt;/span&gt;
&lt;span class='seemore-more'&gt;, quis nostrud exercitation ullamco laboris nisi ut aliquip
ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
sunt in culpa qui officia deserunt mollit anim id est laborum.&lt;span class='seemore-link'&gt;
&lt;a href='#'&gt;(less)&lt;/a&gt;&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;</pre>
<p>Clicking on the (more) link will cause the text to expand, and clicking on the (less) link will cause the text to collapse.</p>
<h2>Callback functionality</h2>
<p>You can specify a callback function which will be called any time text is collapsed or expanded using the $.seemore function. Pass the $.seemore function an object in which the attribute 'callback' is the function you would like to be called, as such:</p>
<pre>$.seemore({callback:function() {
	&nbsp;&nbsp;console.log('text was collapsed or expanded.');
}});</pre>
<p>The callback function can take two arguments: the jQuery objects representing the link that was clicked on, and that link's ancestor element with class 'seemore':</p>
<pre>$.seemore({callback:function(link, ancestor) {
	&nbsp;&nbsp;console.log('the link was: '+link.prop('id')+' and the ancestor was: '+ancestor.prop('id'));
}});</pre>
<h2>Rebinding</h2>
<p>In the case of dynamically loaded html, it may be necessary to rebind the expand and collapse functions to their respective links. Seemorejs includes this functionality simply with the <code>$.smrebind</code> function. Simply call <code>$.smrebind()</code> after your dynamic html has been loaded, and the events will be rebound so that everything just works.</p>
<p>seemore.js was created by Noah Gilmore (noahgilmore.com).</p>
<p>seemore.js is currently in version 1.0.</p>