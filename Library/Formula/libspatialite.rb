require 'formula'

class Libspatialite < Formula
  homepage 'https://www.gaia-gis.it/fossil/libspatialite/index'
  url 'http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-3.0.1.tar.gz'
  sha1 'a88c763302aabc3b74d44a88f969c8475f0c0d10'

  option 'without-freexl', 'Build without support for reading Excel files'

  depends_on 'proj'
  depends_on 'geos'
  # Needs SQLite > 3.7.3 which rules out system SQLite on Snow Leopard and
  # below. Also needs dynamic extension support which rules out system SQLite
  # on Lion. Finally, RTree index support is required as well.
  depends_on 'sqlite'

  depends_on 'freexl' unless build.include? 'without-freexl'

  def install
    # O2 and O3 leads to corrupt/invalid rtree indexes
    # http://groups.google.com/group/spatialite-users/browse_thread/thread/8e1cfa79f2d02a00#
    ENV.Os
    # Ensure Homebrew's libsqlite is found before the system version.
    ENV.append 'LDFLAGS', "-L#{HOMEBREW_PREFIX}/lib"

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-sysroot=#{HOMEBREW_PREFIX}
    ]
    args << '--enable-freexl=no' if build.include? 'without-freexl'

    system './configure', *args
    system "make install"
  end
end
