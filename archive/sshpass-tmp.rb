require 'formula'

class Sshpass < Formula
  url 'https://github.com/JoshRodd/sshpass/blob/master/archive/sshpass-1.06-brew-2017-03-25-2.zip'
  homepage 'https://github.com/JoshRodd/sshpass'
  sha256 '990623670bb55d05f63c7841306922d412f883e7f68a274861b13d908409e1b3'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
