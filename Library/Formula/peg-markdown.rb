require 'formula'

class PegMarkdown < Formula
  homepage 'https://github.com/jgm/peg-markdown'
  url 'https://github.com/jgm/peg-markdown/tarball/0.4.12'
  sha1 'f71dbbf394af95831d780bfd3650eabd8456b7fe'
  head 'https://github.com/jgm/peg-markdown.git'

  depends_on 'pkg-config' => :build
  depends_on 'glib'

  def install
    system 'make'
    bin.install 'markdown' => 'peg-markdown'
  end
end
