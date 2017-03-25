require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd//master/archive/archive/sshpass-1.06-brew-2017-03-25-3.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/'
  sha256 '9c05d8a2393fbbf8077c6b730b58582f5bbf58196242f4c9df8eaf45d8004635'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
