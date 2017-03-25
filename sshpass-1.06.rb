require 'formula'

class Sshpass < Formula
  url 'https://github.com/JoshRodd/sshpass/archive/sshpass-1.06-brew-2017-03-25-2.zip'
  homepage 'https://github.com/JoshRodd/sshpass'
  sha256 '77380dc43408e82d581cb6b7ba18b532135fc445a1621fd690b1ac2a96c97da0'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
