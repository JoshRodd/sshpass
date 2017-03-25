require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd/sshpass/master/archive/sshpass-1.06-brew-2017-03-25-5.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/sshpass'
  sha256 'f595ba540e05c75c046db141610f99883256f3943147b8c4f25a293aace6286d'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
