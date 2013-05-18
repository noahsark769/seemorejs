class Seemore
	constructor: (@options, $element) ->
		@jq = $element
		this.set_default_options()
		this.setup()
		this.bind()

	teardown: ->
		@more_link_jq?.remove()
		@less_link_jq?.remove()
		@more_jq?.replaceWith @more_jq.contents()

	set_default_options: ->
		@max_chars = if @options.max_tokens? then null else @options.max_chars || 30
		@max_tokens = @options.max_tokens || null
		@token_delimiter = @options.token_delimiter || " "
		@postfix = @options.postfix || ""
		@more_link_text = @options.more_link_text || "(more)"
		@less_link_text = @options.less_link_text || "(less)"
		@default_more_display = @options.default_display || "inline"
		@default_link_display = @options.default_display || "inline"
		@expand_callback = @options.expand_callback || ->
		@collapse_callback = @options.collapse_callback || ->
		@expand_by_default = @options.expand_by_default || false
		@link_class = @options.link_class

	setup: ->
		@is_expanded = false

		text = @jq.text()
		max_showable = this.get_max_showable_chars()
		console.log max_showable

		# html in text not supported
		@more_link_jq = $ "<span class='seemore-link more'>#{@postfix} <a>#{@more_link_text}</a></span>"
		@less_link_jq = $ "<span class='seemore-link less'> <a>#{@less_link_text}</a></span>"

		if @link_class
			@more_link_jq.children("a").addClass(@link_class)
			@less_link_jq.children("a").addClass(@link_class)

		# split the text up into two parts
		# automatically works if max_showable > text.length, thanks javascript!
		first = text.slice 0, max_showable
		second = text.slice max_showable, text.length

		@more_jq = $ "<span class='seemore-more'></span>"
		@more_jq.text second
		@more_jq.append @less_link_jq
		@more_jq.css "display", "none"

		# now append everything to the initial element
		@jq.empty()
		@jq.text first
		@jq.append @more_link_jq
		@jq.append @more_jq

		# now everything is ready

		if @expand_by_default
			this.expand()

	get_max_showable_chars: ->
		text = @jq.text()
		if @max_tokens
			all_tokens = text.split(@token_delimiter)
			if all_tokens.length <= @max_tokens
				return text.length

			return all_tokens.slice(0, @max_tokens).join(@token_delimiter).length

		if text.length <= @max_chars
			return text.length

		return text.slice(0, @max_chars).length

	expand: ->
		if @is_expanded
			return
		@more_link_jq.css "display", "none"
		@more_jq.css "display", @default_more_display
		@less_link_jq.css "display", @default_link_display
		@is_expanded = true
		@expand_callback()

	collapse: ->
		if not @is_expanded
			return
		@more_jq.css "display", "none"
		@more_link_jq.css "display", @default_link_display
		@is_expanded = false
		@collapse_callback()

	bind: ->
		_this = this
		@more_link_jq.click ->
			_this.expand()
		@less_link_jq.click ->
			_this.collapse()

$.fn.extend
	seemore: (options) ->
		options = options || {}
		if typeof options == "string"
			if options not in ["raw", "collapse", "expand"]
				options = "raw"
			if options == "raw"
				return this.data "seemore"
			else if options == 'collapse'
				this.data("seemore").collapse()
			else if options == 'expand'
				this.data("seemore").expand()
		else
			if this.data "seemore"
				this.data("seemore").teardown()
			this.data 'seemore', new Seemore(options, this)
		return $ this




