require 'formula'

class Sshpass < Formula
  url 'https://github.com/JoshRodd/sshpass/archive/sshpass-1.06-brew-2017-03-25-2.zip'
  homepage 'https://github.com/JoshRodd/sshpass'
  sha256 'cd3b61a91fd4dccde9263cf47154c0a0c78322fb40933321bed8d0e19f2ddd2a'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
