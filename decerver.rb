#!/usr/bin/ruby
# @Author: caktux
# @Date:   2015-01-08 23:31:33
# @Last Modified by:   caktux
# @Last Modified time: 2015-01-09 00:46:09

require 'formula'

class Decerver < Formula

  version '0.8'

  homepage 'https://github.com/eris-ltd/decerver'
  url 'https://github.com/eris-ltd/decerver.git', :branch => 'master'

  depends_on 'go' => :build
  depends_on 'hg' => :build
  depends_on 'ipfs'
  depends_on 'epm'
  depends_on 'thelonius'

  def install
    ENV["GOPATH"] = "#{buildpath}"
    ENV["GOROOT"] = "#{HOMEBREW_PREFIX}/opt/go/libexec"

    # Debug env
    system "go", "env"
    base = "src/github.com/eris-ltd/decerver"

    mkdir_p base
    Dir["**"].reject{ |f| f['src']}.each do |filename|
      move filename, "#{base}/"
    end

    cmd = "#{base}/cmd/"

    # Get dependencies
    system "go", "get", "-v", "-t", "-d", "./#{cmd}decerver"

    system "go", "install", "-v", "./#{cmd}decerver"

    bin.install Dir['bin/*']

    prefix.install Dir['**']
  end

  test do
    system "decerver"
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>ThrottleInterval</key>
        <integer>300</integer>
        <key>ProgramArguments</key>
        <array>
            <string>#{opt_bin}/decerver</string>
        </array>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
      </dict>
    </plist>
    EOS
  end
end
__END__
