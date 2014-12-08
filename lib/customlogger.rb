require 'json'
require 'customlogger/version'
require 'customlogger/html_template'

module CustomLogger
  LOOP_LIMIT = 512
  SECTION_HTML = '<section><hr></section>'

  class << self
    def path=(value)
      @log_path = value
    end

    def path
      @log_path||=[ Dir.pwd, '/log' ].join
    end

    def file=(value)
      @file_name = value
    end

    def file
      @file_name||='CustomLogger.html'
    end

    def title=(value)
      @title = value
    end

    def title
      @title||='Custome Logger'
    end

    def error_color(state, color)
      set_error_colors if @error_colors.nil?
      @error_colors[state] = color
    end

    def error_colors
      @error_colors||=set_error_colors
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

    def new_line
      log(:section, nil, nil)
      SECTION_HTML
    end

    private
      def set_error_colors
        @error_colors = {
          error: '#8b0000',  warning: '#6d422e',
          debug: '#2d5a2e',  info: '#31708f'
        }
      end

      def new_log_file
        file_path_name = [ path, file ].join('/')
        system "mkdir -p #{path}"
        File.open(file_path_name, 'w') { |file| file.write(html) }
      end

      def log(state, message, title = nil)
        if !title.nil? && !title.is_a?(String)
          title = title.inspect
        end

        unless %w(Array Hash String).include?(message.class.name)
          if message.is_a?(ActiveRecord::Base)
            message = JSON.pretty_generate(message.as_json)
            message = message.gsub!(/\n/,'<br>')
          else
            message = message.inspect
          end
        end

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
        case state
          when :raw
            HTMLTemplate.raw_to_html(message, title)
          when :section
            SECTION_HTML
          else
            HTMLTemplate.log_to_html(state, message, title)
        end
      end

      def html
        error_colors
        HTMLTemplate.html(@title, @error_colors)
      end

  end
end
