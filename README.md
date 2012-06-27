<h1>seemore.js</h1>

<p>A lightweight, simple jQuery framework for partial collapse and expand of html.</p>

<p>To use seemore.js, include jQuery and the seemore.js javascript source file in your html page with <code>&lt;script type='text/javascript' src='jquery.min.js'&gt;&lt;/script&gt;&lt;script type='text/javascript' src='seemore.js'&gt;&lt;/script&gt;</code>. Wrap your partially collapsable html in an element with class 'seemore', the part you would like hidden by default in an element with class 'seemore-more', and your toggle links in an element with class 'seemore-link' as such:</p>
<code>&lt;p class='seemore'&gt;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut<br> labore et dolore magna aliqua. Ut enim ad minim veniam&lt;span class='seemore-link'&gt;... &lt;a href='#'&gt;(more)&lt;/a&gt;<br>&lt;/span&gt;&lt;span class='seemore-more'&gt;, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br> consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur<br>sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<br>&lt;span class='seemore-link'&gt; &lt;a href='#'&gt;(less)&lt;/a&gt;&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;</code>
<p>Clicking on the (more) link will cause the text to expand, and clicking on the (less) link will cause the text to collapse.</p>
<h2>Callback functionality</h2>
<p>You can specify a callback function which will be called any time text is collapsed or expanded using the $.seemore function. Pass the $.seemore function an object in which the attribute 'callback' is the function you would like to be called, as such:</p>
<code>$.seemore({callback:function() {<br>
	&nbsp;&nbsp;console.log('text was collapsed or expanded.');<br>
}});</code>
<p>The callback function can take two arguments: the jQuery objects representing the link that was clicked on, and that link's ancestor element with class 'seemore':</p>
<code>$.seemore({callback:function(link, ancestor) {<br>
	&nbsp;&nbsp;console.log('the link was: '+link.prop('id')+' and the ancestor was: '+ancestor.prop('id'));<br>
}});</code>
<p>seemore.js was created by Noah Gilmore (noahgilmore.com).</p>
<p>seemore.js is currently in version 1.0.</p>