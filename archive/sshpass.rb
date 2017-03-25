require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd/sshpass/master/archive/archive/sshpass-1.06-brew-2017-03-25-3.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/sshpass'
  sha256 '72f8b1c71ff4aaf2e2248b08a5176143753220d969ddfecff9c20a0110fd5dfe'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
