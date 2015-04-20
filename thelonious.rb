#!/usr/bin/ruby
# @Author: caktux
# @Date:   2015-01-09 00:24:24
# @Last Modified by:   caktux
# @Last Modified time: 2015-04-20 00:47:29

require 'formula'

class Thelonious < Formula

  version '0.8.1'

  homepage 'https://github.com/eris-ltd/thelonious'
  url 'https://github.com/eris-ltd/thelonious.git', :branch => 'master'

  depends_on 'go' => :build
  depends_on 'hg' => :build

  def install
    ENV["GOPATH"] = "#{buildpath}/Godeps/_workspace:#{buildpath}"
    ENV["GOROOT"] = "#{HOMEBREW_PREFIX}/opt/go/libexec"

    # Debug env
    system "go", "env"
    base = "src/github.com/eris-ltd/thelonious"

    mkdir_p base
    Dir["**"].reject{ |f| f['src']}.each do |filename|
      move filename, "#{base}/"
    end

    # cmd = "#{base}/"

    # Get dependencies
    # system "go", "get", "-v", "-t", "-d", "./#{cmd}monk"

    # system "go", "install", "-v", "./#{cmd}monk"

    # bin.install Dir['bin/*']

    prefix.install Dir['src']
  end

  # test do
  #   system "monk"
  # end

  # def plist; <<-EOS.undent
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  #   <plist version="1.0">
  #     <dict>
  #       <key>Label</key>
  #       <string>#{plist_name}</string>
  #       <key>RunAtLoad</key>
  #       <true/>
  #       <key>KeepAlive</key>
  #       <true/>
  #       <key>ThrottleInterval</key>
  #       <integer>300</integer>
  #       <key>ProgramArguments</key>
  #       <array>
  #           <string>#{opt_bin}/monk</string>
  #       </array>
  #       <key>WorkingDirectory</key>
  #       <string>#{HOMEBREW_PREFIX}</string>
  #     </dict>
  #   </plist>
  #   EOS
  # end
end
__END__
