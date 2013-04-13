class Seemore
	constructor: (options, $element) ->
		@jq = $element
		@options = options || {}
		this.set_default_options()
		this.setup()
		this.bind()

	set_default_options: ->
		@max_chars = if @options.max_tokens? then null else @options.max_chars || 30
		@max_tokens = @options.max_tokens || null
		@token_delimiter = @options.token_delimiter || " "
		@postfix = @options.postfix || "..."
		@more_link_text = @options.more_link_text || "(more)"
		@less_link_text = @options.more_link_text || "(less)"
		@default_more_display = @options.default_display || "inline"
		@default_link_display = @options.default_display || "inline"
		@expand_callback = @options.expand_callback?
		@collapse_callback = @options.collapse_callback?
		@expand_by_default = @options.expand_by_default || false

	setup: ->
		@is_expanded = false

		text = @jq.text()
		max_showable = this.get_max_showable_chars

		# html in text not supported
		@more_link_jq = $ "<span class='seemore-link more'>#{@postfix} <a href='#'>#{@more_link_text}</a></span>"
		@less_link_jq = $ "<span class='seemore-link less'> <a href='#'>#{@less_link_text}</a></span>"

		# split the text up into two parts
		first = text.slice 0, max_showable
		second = text.slice max_showable, text.length

		@more_jq = $ "<span class='seemore-more'></span>"
		more_jq.text second
		more_jq.append less_link_html
		more_jq.css "display", "none"

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

			return @token_delimiter.join(all_tokens.slice(0, @max_tokens)).length

		if text.length <= @max_chars
			return text.length

		return text.slice(0, @max_chars).length

	expand: ->
		@more_link_jq.css "display", "none"
		@more_jq.css "display", @default_more_display
		@is_expanded = true
		@expand_callback()

	collapse: ->
		@more_jq.css "display", "none"
		@more_link_jq.css "display", @default_link_display
		@is_expanded = false
		@collapse_callback()

	bind: ->
		@more_link_jq.click ->
			this.expand()
		@less_link_jq.click ->
			this.collapse()

$ = jQuery

$.fn.extend
	seemore: (options) ->
		if typeof options == "string"
			if options == "raw"
				return this.data "seemore"
			else if options == 'collapse'
				this.data("seemore").collapse()
			else if options == 'expand'
				this.data("seemore").expand()
		else
			this.data('seemore', new Seemore(options, this))




