require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd//master/archive/archive/sshpass-1.06-brew-2017-03-25-3.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/'
  sha256 '1d90bf49d9b76f82fd01b3bed05215fa5d5617a25d59aa1577627664ef1ca208'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
