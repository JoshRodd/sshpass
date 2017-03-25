require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd/sshpass/master/archive/sshpass-1.06-brew-2017-03-25-4.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/sshpass'
  sha256 '96bf0f10905ec43fa194ff9c459500db86665f23030ccb5ca8e394bb376028b6'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
