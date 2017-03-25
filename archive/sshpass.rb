require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd/sshpass/master/archive/sshpass-1.06-brew-2017-03-25-4.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/sshpass'
  sha256 'b4676c40ae70e95a99cda4be52e7405b1d2ead77a4ac25ae2d9fd8ec468e4bab'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
