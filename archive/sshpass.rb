require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd/sshpass/master/archive/sshpass-1.06-brew-2017-03-25-4.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/sshpass'
  sha256 'c0bc5f484f72730e304ce4dd7d93b6061a795f4b6fd580ac5095215486bf7161'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
