require "customlogger/version"

module CustomLogger
  LOOP_LIMIT = 512

  class << self
    def path=(value)
      @log_path = value
    end

    def path
      if @log_path.nil?
        [ Dir.pwd, '/log' ].join
      else
        @log_path
      end
    end

    def file=(value)
      @file_name = value
    end

    def file
      if @file_name.nil?
        'CustomLogger.html'
      else
        @file_name
      end
    end

    def title=(value)
      @title = value
    end

    def title
      if @title.nil?
        'Custome Logger'
      else
        @title
      end
    end

    def error_color(state, color)
      set_error_colors if @error_colors.nil?
      @error_colors[state] = color
    end

    def error_colors
      set_error_colors if @error_colors.nil?
      @error_colors
    end

    def new
      new_log_file
      'Wiped All Old Logs'
    end

    def clear
      new_log_file
      'Wiped All Old Logs'
    end

    def error=(value)
      log(:error, value)
      value
    end

    def error(value, title=nil)
      log(:error, value, title)
      value
    end

    def warning=(value)
      log(:warning, value)
      value
    end

    def warning(value, title=nil)
      log(:warning, value, title)
      value
    end

    def debug=(value)
      log(:debug, value)
      value
    end

    def debug(value, title=nil)
      log(:debug, value, title)
      value
    end

    def info=(value)
      log(:info, value)
      value
    end

    def info(value, title=nil)
      log(:info, value, title)
      value
    end

    def raw=(value)
      log(:raw, value)
      value
    end

    def raw(value, title=nil)
      log(:raw, value, title)
      value
    end

    private
      def set_error_colors
        @error_colors = {
          error: '#8b0000',  warning: '#614c29',
          debug: '#2d5a2e',  info: '#31708f'
        }
      end

      def new_log_file
        file_path_name = [ path, file ].join('/')
        File.open(file_path_name, 'w') { |file| file.write(html) }
      end

      def log(state, message, title = nil)
        if @logged_total.nil?
          @logged_total = 0
        else
          abort('Infinite loop possibility!!') if @logged_total > LOOP_LIMIT
        end

        file_path_name = [ path, file ].join('/')
        new_log_file unless File.exist?(file_path_name)

        written_logs = File.read(file_path_name)
        written_logs = written_logs[0..-15].to_s
        written_logs = written_logs[0...-1] if written_logs[-1] == '<'
        written_logs.concat(to_html(state, message, title))
        written_logs.concat('</body></html>')
        File.open(file_path_name, 'w') { |file| file.write(written_logs) }
        @logged_total += 1
      end

      def to_html(state, message, title)
        if state == :raw
          if title.nil?
            [ '<div class="', state, '"><pre>', message, '</pre><time>',
              Time.now, '</time></div>' ].join
          else
            [ '<div class="', state, '"><header>', title, '</header><pre>',
              message, '</pre><time>', Time.now, '</time></div>' ].join
          end
        else
          if title.nil?
            [ '<div class="', state, '">', message, '<time>',
              Time.now, '</time></div>' ].join
          else
            [ '<div class="', state, '"><header>', title, '</header>',
              message, '<time>', Time.now, '</time></div>' ].join
          end
        end
      end

      def html
        error_colors
        <<-HTML
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>#{@title}</title>
  <style>
    .error {
      font-family: monospace, monospace, serif;
      font-size: 0.9em;
      color: #{@error_colors[:error]};
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
      color: #{@error_colors[:warning]};
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
      color: #{@error_colors[:debug]};
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
      color: #{@error_colors[:info]};
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

  end
end
