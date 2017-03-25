require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd/sshpass/master/archive/archive/sshpass-1.06-brew-2017-03-25-3.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/sshpass'
  sha256 'efb5ab078c9aa0cd109011e17b1561490dfba1f5409e05671b04d0882d58feed'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
