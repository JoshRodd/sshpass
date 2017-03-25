require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd/sshpass/master/archive/sshpass-1.06-brew-2017-03-25-4.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/sshpass'
  sha256 'a01b78b00c270191acbbf365ea94e5acaae40ecbf2e57a8eb2ece2ca6af99ab0'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
