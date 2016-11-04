# motion-macos-screenshothelper

A gem for taking automated screenshots in macOS applications written in Rubymotion.

## Installation

Add this line to your application's Gemfile:

    gem 'motion-macos-screenshothelper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-macos-screenshothelper

## Usage

Add the ScreenshotHelper tool to your spec files like so:

```
describe 'My application' do
  before do
    @app = NSApplication.sharedApplication
    @sh = Motion::ScreenshotHelper.new(my_config)
  end

  it 'takes a screenshot' do
    @sh.shoot.should == true
  end

  it 'takes a screenshot after waiting' do
  	# do something import with your GUI
  	@sh.pause(1.0) # time in seconds to wait
	@sh.shoot.should == true
  end
end
````

You may set the following config options when calling ```Motion::ScreenshotHelper.new`:

```
my_config = {
      screenshot_mode: Motion::ScreenshotHelper::SCREENSHOT_MODE_FULLSCREEN, # for full-screenshots
      shots_dir: 'screenshots', # the target dir for the screenshot files
      file_basename: 'screenshot', # the basename for the screenshot files (a counter will be added) e.g. 'screenshot_0.png'
      app_name: NSBundle.mainBundle.infoDictionary['CFBundleName'] # your application name needed for focusing the app with AppleScript
}
```

ScreenshotHelper will make use of the screencapture command line tool.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
