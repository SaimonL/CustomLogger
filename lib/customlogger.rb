require 'json'
require 'customlogger/version'
require 'customlogger/html_template'


module CustomLogger
  LOOP_LIMIT = 2048
  SECTION_HTML = '<section><hr></section>'

  @log_path = [ Dir.pwd, '/log' ].join
  @file_name = 'custom_logger.html'

  @title = 'Custom Logger'
  @error_colors = {
    error: '#8b0000',  warning: '#5e3927',
    debug: '#004000',  info: '#1b3d4f'
  }

  @auto_clear = false

  @logged_total = 0

  class << self
    def path=(value)
      @log_path = value
    end

    def path
      if @log_path.nil? || @log_path == ''
        [ Dir.pwd, '/log' ].join
      else
        @log_path
      end
    end

    def file=(value)
      @file_name = value
    end

    def file
      if @file_name.nil? || @file_name == ''
        'custom_logger.html' 
      else
        @file_name
      end
    end

    def title=(value)
      @title = value
    end

    def title
      @title
    end

    def error_color(state, color)
      @error_colors[state] = color
    end

    def error_colors
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

    def auto_clear=(value)
      @auto_clear = value
    end

    def auto_clear
      @auto_clear
    end

    def error(value, title=nil)
      clear if @auto_clear
      log(:error, value, title)
      value
    end

    def warning(value, title=nil)
      clear if @auto_clear
      log(:warning, value, title)
      value
    end

    def debug(value, title=nil)
      clear if @auto_clear
      log(:debug, value, title)
      value
    end

    def info(value, title=nil)
      clear if @auto_clear
      log(:info, value, title)
      value
    end

    def raw(value, title=nil)
      clear if @auto_clear
      log(:raw, value, title)
      value
    end

    def new_line
      log(:section, nil, nil)
      SECTION_HTML
    end

    def demo
      clear
      error 'This is an error message...', 'Error'
      warning 'This is a warning message...', 'Warning'
      info 'This is an info message...', 'Info'
      debug 'This is an debug message...', 'Debug'
      raw 'This is an raw message...', 'Raw'
      [ 'Demo complete for file: ', file ].join
    end

    private
      def new_log_file
        file_path_name = [ path, file ].join('/')
        system "mkdir -p #{path}"
        File.open(file_path_name, 'w') { |file| file.write(html) }
      end

      def log(state, message, title = nil)
        title = format_title(title)
        message = format_message(message)

        abort('Infinite loop possibility!!') if @logged_total > LOOP_LIMIT

        file_path_name = [ path, file ].join('/')
        new_log_file unless File.exist?(file_path_name)

        written_logs = build_log(file_path_name, state, message, title)
        File.open(file_path_name, 'w') { |file| file.write(written_logs) }
        @logged_total += 1
      end

      def format_title(title)
        if !title.nil? && !title.is_a?(String)
          title = title.inspect
        end
        title
      end

      def format_message(message)
        unless %w(Array Hash String).include?(message.class.name)
          if defined?(Module::ActiveRecord).nil?
            message = message.inspect
          else
            if message.is_a?(ActiveRecord::Base)
              message = JSON.pretty_generate(message.as_json)
              message = message.gsub!(/\n/,'<br>')
            end
          end
        end
        message
      end

      def to_html(state, message, title)
        case state
          when :raw
            HTMLTemplate.raw_to_html(message, title)
          when :section
            SECTION_HTML
          else
            HTMLTemplate.log_to_html(state, message, title)
        end
      end

      def build_log(file_path_name, state, message, title)
        written_logs = File.read(file_path_name)
        written_logs = written_logs[0..-15].to_s
        written_logs = written_logs[0...-1] if written_logs[-1] == '<'
        written_logs.concat(to_html(state, message, title))
        written_logs.concat('</body></html>')
      end

      def html
        error_colors
        HTMLTemplate.html(@title, @error_colors)
      end

  end
end
