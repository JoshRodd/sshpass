require 'formula'

class Sshpass < Formula
  url 'https://raw.githubusercontent.com/JoshRodd/sshpass/master/archive/archive/sshpass-1.06-brew-2017-03-25-3.zip'
  homepage 'https://raw.githubusercontent.com/JoshRodd/sshpass'
  sha256 'f8635fded388092e05a11747eda66bf74d3a06c1792bbb6459ccad278ac888e9'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
