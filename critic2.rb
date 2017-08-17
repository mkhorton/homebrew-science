class Critic2 < Formula
  desc "Analysis of quantum chemical interactions in molecules and solids."
  homepage "https://github.com/aoterodelaroza/critic2"
  url "https://github.com/aoterodelaroza/critic2/archive/stable.tar.gz"
  version "stable"
  sha256 "5c0803d47fbbb061b9f0b44e56eeebd7aa3298b275b9253fecdae7847a1ff903"

  option "with-libxc", "Compile with libxc support to calculate exchange and correlation densities"

  depends_on "gcc" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libxc" => :optional

  def install
    system "autoreconf", "-i"

    if build.with? "libxc"
      system "./configure", "--with-libxc-prefix=#{HOMEBREW_PREFIX}/lib",
                            "--with-libxc-include=#{HOMEBREW_PREFIX}/include",
                            "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{prefix}"
    end

    if build.without? "libxc"
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{prefix}"
    end

    system "make"
    system "make", "install"
  end

  test do
    touch("empty.cri")
    system "#{bin}/critic2", "empty.cri"
  end
end
