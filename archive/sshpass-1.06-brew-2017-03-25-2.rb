require 'formula'

class Sshpass < Formula
  url 'https://github.com/JoshRodd/sshpass/archive/sshpass-1.06-brew-2017-03-25-2.zip'
  homepage 'https://github.com/JoshRodd/sshpass'
  sha256 '54c9e55834f4c8efce67c0b514833c2d371c94b10527bd7b91d344dc7bbd037a'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
