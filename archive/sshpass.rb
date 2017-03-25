require 'formula'

class Sshpass < Formula
  url 'https://github.com/JoshRodd/sshpass/archive/sshpass-1.06-brew-2017-03-25-2.zip'
  homepage 'https://github.com/JoshRodd/sshpass'
  sha256 'fc9cd5e063751e7ff10418b718a9a4d0c002e1eab5c149b220c372577f5d8320'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
