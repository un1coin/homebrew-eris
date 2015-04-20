#!/usr/bin/ruby
# @Author: caktux
# @Date:   2015-01-09 00:09:40
# @Last Modified by:   caktux
# @Last Modified time: 2015-04-20 00:43:11

require 'formula'

class Ipfs < Formula

  version '0.1.7'

  homepage 'https://github.com/eris-ltd/go-ipfs'
  url 'https://github.com/eris-ltd/go-ipfs.git', :branch => 'master'

  depends_on 'go' => :build
  depends_on 'hg' => :build

  def install
    ENV["GOPATH"] = "#{buildpath}/Godeps/_workspace:#{buildpath}"
    ENV["GOROOT"] = "#{HOMEBREW_PREFIX}/opt/go/libexec"

    # Debug env
    system "go", "env"
    base = "src/github.com/eris-ltd/go-ipfs"

    mkdir_p base
    Dir["**"].reject{ |f| f['src']}.each do |filename|
      move filename, "#{base}/"
    end

    cmd = "#{base}/cmd/"

    # Get dependencies
    # system "go", "get", "-v", "-t", "-d", "./#{cmd}ipfs"

    system "go", "install", "-v", "./#{cmd}ipfs"

    bin.install Dir['bin/*']

    prefix.install Dir['src']
  end

  test do
    system "ipfs"
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
            <string>#{opt_bin}/ipfs</string>
        </array>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
      </dict>
    </plist>
    EOS
  end
end
__END__
