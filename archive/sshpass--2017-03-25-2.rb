require 'formula'

class Sshpass < Formula
  url 'https://github.com/JoshRodd/sshpass/archive/sshpass-1.06-brew-2017-03-25-2.zip'
  homepage 'https://github.com/JoshRodd/sshpass'
  sha256 '400842c420885574dd7fefcd4b4fe1c9435e9e3c75e383195a340325ef71b628'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
