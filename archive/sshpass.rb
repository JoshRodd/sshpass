require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd//master/archive/archive/sshpass-1.06-brew-2017-03-25-3.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/'
  sha256 '602a045cd2f9b6b68eaeb01510aaf9cb884e893bbd8539e9b7636e8744d21ad3'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
