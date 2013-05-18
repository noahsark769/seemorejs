// Generated by CoffeeScript 1.6.2
(function() {
  var Seemore;

  Seemore = (function() {
    function Seemore(options, $element) {
      this.options = options;
      this.jq = $element;
      this.set_default_options();
      this.setup();
      this.bind();
    }

    Seemore.prototype.set_default_options = function() {
      this.max_chars = this.options.max_tokens != null ? null : this.options.max_chars || 30;
      this.max_tokens = this.options.max_tokens || null;
      this.token_delimiter = this.options.token_delimiter || " ";
      this.postfix = this.options.postfix || "";
      this.more_link_text = this.options.more_link_text || "(more)";
      this.less_link_text = this.options.less_link_text || "(less)";
      this.default_more_display = this.options.default_display || "inline";
      this.default_link_display = this.options.default_display || "inline";
      this.expand_callback = this.options.expand_callback || function() {};
      this.collapse_callback = this.options.collapse_callback || function() {};
      this.expand_by_default = this.options.expand_by_default || false;
      return this.link_class = this.options.link_class;
    };

    Seemore.prototype.setup = function() {
      var first, max_showable, second, text;

      this.is_expanded = false;
      text = this.jq.text();
      max_showable = this.get_max_showable_chars();
      console.log(max_showable);
      this.more_link_jq = $("<span class='seemore-link more'>" + this.postfix + " <a>" + this.more_link_text + "</a></span>");
      this.less_link_jq = $("<span class='seemore-link less'> <a>" + this.less_link_text + "</a></span>");
      if (this.link_class) {
        this.more_link_jq.children("a").addClass(this.link_class);
        this.less_link_jq.children("a").addClass(this.link_class);
      }
      first = text.slice(0, max_showable);
      second = text.slice(max_showable, text.length);
      this.more_jq = $("<span class='seemore-more'></span>");
      this.more_jq.text(second);
      this.more_jq.append(this.less_link_jq);
      this.more_jq.css("display", "none");
      this.jq.empty();
      this.jq.text(first);
      this.jq.append(this.more_link_jq);
      this.jq.append(this.more_jq);
      if (this.expand_by_default) {
        return this.expand();
      }
    };

    Seemore.prototype.get_max_showable_chars = function() {
      var all_tokens, text;

      text = this.jq.text();
      if (this.max_tokens) {
        all_tokens = text.split(this.token_delimiter);
        if (all_tokens.length <= this.max_tokens) {
          return text.length;
        }
        return all_tokens.slice(0, this.max_tokens).join(this.token_delimiter).length;
      }
      if (text.length <= this.max_chars) {
        return text.length;
      }
      return text.slice(0, this.max_chars).length;
    };

    Seemore.prototype.expand = function() {
      if (this.is_expanded) {
        return;
      }
      this.more_link_jq.css("display", "none");
      this.more_jq.css("display", this.default_more_display);
      this.less_link_jq.css("display", this.default_link_display);
      this.is_expanded = true;
      return this.expand_callback();
    };

    Seemore.prototype.collapse = function() {
      if (!this.is_expanded) {
        return;
      }
      this.more_jq.css("display", "none");
      this.more_link_jq.css("display", this.default_link_display);
      this.is_expanded = false;
      return this.collapse_callback();
    };

    Seemore.prototype.bind = function() {
      var _this;

      _this = this;
      this.more_link_jq.click(function() {
        return _this.expand();
      });
      return this.less_link_jq.click(function() {
        return _this.collapse();
      });
    };

    return Seemore;

  })();

  $.fn.extend({
    seemore: function(options) {
      options = options || {};
      if (typeof options === "string") {
        if (options !== "raw" && options !== "collapse" && options !== "expand") {
          options = "raw";
        }
        if (options === "raw") {
          return this.data("seemore");
        } else if (options === 'collapse') {
          this.data("seemore").collapse();
        } else if (options === 'expand') {
          this.data("seemore").expand();
        }
      } else {
        this.data('seemore', new Seemore(options, this));
      }
      return $(this);
    }
  });

}).call(this);
