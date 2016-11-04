module Motion
  # A class for taking screenshots in Ruby apps running on the Mac
  class ScreenshotHelper

    attr_accessor :config

    SCREENSHOT_MODE_FULLSCREEN = 0
    SCREENSHOT_MODE_MAINWINDOW = 1

    def initialize(config)
      self.config = default_config.merge(config)
      @counter = 0
      clear_dir
      self
    end

    def default_config
      {
        screenshot_mode: SCREENSHOT_MODE_FULLSCREEN,
        shots_dir: 'screenshots',
        file_basename: 'screenshot',
        app_name: NSBundle.mainBundle.infoDictionary['CFBundleName']
      }
    end

    def target_filename
      "#{config[:shots_dir]}/#{config[:file_basename].to_s}_#{@counter.to_s}.png"
    end

    def shoot
      begin
        focus_app
        system screenshot_cmd
        @counter += 1
      rescue Exception => e
        puts "Exception #{e}"
        return false
      end
      true
    end

    def pause(sec=1.0)
      intervall = NSDate.dateWithTimeIntervalSinceNow sec
      NSThread.sleepUntilDate intervall
    end

    private

    def check_shots_dir
      self.config[:shots_dir] = File.absolute_path(config[:shots_dir])
      fail(IOError, "#{config[:shots_dir]} is not a directory") unless File.directory?(ndir)
    end

    def app
      NSApplication.sharedApplication
    end

    def screenshot_cmd
      screen_rect = NSScreen.mainScreen.frame
      case config[:screenshot_mode]
      when ScreenshotHelper::SCREENSHOT_MODE_MAINWINDOW
        fr = app_window.frame
        x_origin = fr.origin[0]
        y_origin = screen_rect.size[1] - fr.origin[1] - fr.size[1]
        capture_frame = "#{x_origin},#{y_origin},#{fr.size[0]},#{fr.size[1]}"
        rv  = "screencapture -R#{capture_frame} #{target_filename}"
      else
        rv = "screencapture #{target_filename}"
      end
      rv
    end

    def app_window
      return app.mainWindow unless app.mainWindow.nil?
      return app.keyWindow unless app.keyWindow.nil?
      app.windows.first
    end

    def focus_app
      scpt = <<SCPT
      tell application "#{config[:app_name]}"
      activate
    end tell
SCPT
      osascript scpt
    end

    def osascript(script_src)
      error = Pointer.new('@')
      apple_script = NSAppleScript.alloc.initWithSource(script_src)
      apple_script.executeAndReturnError(error)
      puts "NSAppleScript::error #{error.value.inspect}" unless error.value.nil?
    end

    def clear_dir
      cmd = "rm -rf #{(config[:shots_dir] + '/*').dump}"
      system cmd
    end
  end
end
