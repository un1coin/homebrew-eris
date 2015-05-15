#!/usr/bin/ruby
# @Author: caktux
# @Date:   2015-01-09 00:17:58
# @Last Modified by:   caktux
# @Last Modified time: 2015-04-20 00:43:13

require 'formula'

class Epm < Formula

  version '0.8.3'

  homepage 'https://github.com/eris-ltd/epm-go'
  url 'https://github.com/eris-ltd/epm-go.git', :branch => 'master'

  depends_on 'go' => :build
  depends_on 'hg' => :build
  depends_on 'gmp'

  def install
    ENV["GOPATH"] = "#{buildpath}/Godeps/_workspace:#{buildpath}"
    ENV["GOROOT"] = "#{HOMEBREW_PREFIX}/opt/go/libexec"

    # Debug env
    system "go", "env"
    base = "src/github.com/eris-ltd/epm-go"

    mkdir_p base
    Dir["**"].reject{ |f| f['src']}.each do |filename|
      move filename, "#{base}/"
    end

    cmd = "#{base}/cmd/"

    # Get dependencies
    # system "go", "get", "-v", "-t", "-d", "./#{cmd}epm"

    system "go", "install", "-v", "./#{cmd}epm"

    bin.install Dir['bin/*']

    prefix.install Dir['src']
  end

  test do
    system "epm"
  end
end
__END__
