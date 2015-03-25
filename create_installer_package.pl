use strict;
use warnings;

use Cwd qw(abs_path);
use FindBin;
use Data::Dumper;

my $base_path = abs_path($FindBin::Bin);

my $verbose = 1;
my $packages = "packages";
my $arch = "x86";
my $archpostfix = $arch eq "" ? "" : "-$arch";

# my $root = "http://download.osgeo.org/osgeo4w";
# my $ininame = "setup.ini";
my $unpacked = "unpacked";
my $wgetopt = $verbose ? "" : "-q";
my $taropt = "v" x $verbose;
my $keep = 0;
my $releasename = "edugis";


my $major = 2;
my $minor = 1;
my $patch = 0;
my $binary = 0;
my $version = "$major.$minor.$patch";

my $packagename = "QGIS";
my $shortname = "qgis";

my $license = "license.tmp";


print "Running NSIS\n" if $verbose;

my $cmd = "makensis";
$cmd .= " /V$verbose";
$cmd .= " /DVERSION_NAME=$releasename";
$cmd .= " /DVERSION_NUMBER=$version";
$cmd .= " /DBINARY_REVISION=$binary";
$cmd .= sprintf( " -DVERSION_INT=%d%02d%02d%02d", $major, $minor, $patch, $binary );
$cmd .= " /DQGIS_BASE=\"$packagename $releasename\"";
$cmd .= " /DcxxxxxxxxxxlkkkkkkkkkkInstaller-Files_NAME=$packagename-OSGeo4W-$version-$binary-Setup$archpostfix.exe";
$cmd .= " /DDISPLAYED_NAME=\"$packagename $releasename ($version)\"";
$cmd .= " /DSHORTNAME=$shortname";
$cmd .= " /DINSTALLER_TYPE=OSGeo4W";
$cmd .= " /DPACKAGE_FOLDER=$unpacked";
$cmd .= " /DLICENSE_FILE=$base_path/assets/license/GPL-2.0.txt";
$cmd .= " /DARCH=$arch";
$cmd .= " QGIS-Installer.nsi";

#print $cmd;

system $cmd;

die "running nsis failed" if $?;