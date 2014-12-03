class HTMLTemplate
  class << self
    def html(title, error_colors)
      <<-HTML
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8">
    <title>#{title}</title>
    <style>
      .error {
        font-family: monospace, monospace, serif;
        font-size: 0.9em;
        color: #{error_colors[:error]};
        background-color: #f2dede;
        border-color: #8b0000;
        padding: 8px;
        border: 1px solid darkred;
        border-radius: 4px;
        margin-bottom: 4px;
      }
      .error header {
        font-size: 1.2em;;
        font-weight: bold;
        padding-bottom: 4px;
      }
      .error summary { padding-left: 8px; }
      .error time {
        font-family: monospace, monospace, serif;
        font-size: 0.68em;
        display: block;
        padding-top: 8px;
      }

      .warning {
        font-family: monospace, monospace, serif;
        font-size: 0.9em;
        color: #{error_colors[:warning]};
        background-color: #fcf8e3;
        border-color: #faebcc;
        padding: 8px;
        border: 1px solid #faebcc;
        border-radius: 4px;
        margin-bottom: 4px;
      }
      .warning header {
        font-size: 1.2em;;
        font-weight: bold;
        padding-bottom: 4px;
      }
      .warning summary { padding-left: 8px; }
      .warning time {
        font-family: monospace, monospace, serif;
        font-size: 0.68em;
        display: block;
        padding-top: 8px;
      }

      .debug {
        font-family: monospace, monospace, serif;
        font-size: 0.9em;
        color: #{error_colors[:debug]};
        background-color: #eafbe2;
        border-color: #bbcbad;
        padding: 8px;
        border: 1px solid #bbcbad;
        border-radius: 4px;
        margin-bottom: 4px;
      }
      .debug header {
        font-size: 1.2em;;
        font-weight: bold;
        padding-bottom: 4px;
      }
      .debug summary { padding-left: 8px; }
      .debug time {
        font-family: monospace, monospace, serif;
        font-size: 0.68em;
        display: block;
        padding-top: 8px;
      }

      .info {
        font-family: monospace, monospace, serif;
        font-size: 0.9em;
        color: #{error_colors[:info]};
        background-color: #e0f5ff;
        border-color: #a6ccd4;
        padding: 8px;
        border: 1px solid #a6ccd4;
        border-radius: 4px;
        margin-bottom: 4px;
      }
      .info header {
        font-size: 1.2em;;
        font-weight: bold;
        padding-bottom: 4px;
      }
      .info summary { padding-left: 8px; }
      .info time {
        font-family: monospace, monospace, serif;
        font-size: 0.68em;
        display: block;
        padding-top: 8px;
      }

      .raw {
        font-family: monospace, monospace, serif;
        font-size: 0.9em;
        color: #303030;
        background-color: #dcdcdc;
        border-color: #a0a0a0;
        padding: 8px;
        border: 1px solid #a0a0a0;
        border-radius: 4px;
        margin-bottom: 4px;
      }
      .raw header {
        font-size: 1.2em;;
        font-weight: bold;
        padding-bottom: 4px;
      }
      .raw pre { padding-left: 8px; }
      .raw time {
        font-family: monospace, monospace, serif;
        font-size: 0.68em;
        display: block;
        padding-top: 8px;
      }

      section { padding: 28px; }
    </style>
  </head>
  <body>
  <h2>Custome Logger</h2>
  </body></html>
      HTML
    end

    def raw_to_html(message, title)
      if title.nil?
        [ '<div class="raw"><pre>', message, '</pre><time>', Time.now,
          '</time></div>' ].join
      else
        [ '<div class="raw"><header>', title, '</header><pre>', message,
          '</pre><time>', Time.now, '</time></div>' ].join
      end
    end

    def log_to_html(state, message, title)
      if title.nil?
        [ '<div class="', state, '">', message, '<time>',
          Time.now, '</time></div>' ].join
      else
        [ '<div class="', state, '"><header>', title, '</header>',
          message, '<time>', Time.now, '</time></div>' ].join
      end
    end
  end
end