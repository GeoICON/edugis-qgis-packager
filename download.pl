use strict;
use warnings;

use Cwd qw(abs_path);
use File::Copy qw(copy);
use FindBin;
use Data::Dumper;

my $base_path = abs_path($FindBin::Bin);

require("$base_path/Common.pm");


my $verbose = 1;
my $arch = "x86";
my $base_url = "http://download.osgeo.org/osgeo4w";
my $ininame = "setup.ini";
my $packages = "packages";
my $archpath = $arch eq "" ? "" : "/$arch";
my $wgetopt = $verbose ? "" : "-q";


unless(-f "nsis/System.dll") {
    mkdir "nsis", 0755 unless -d "nsis";
    system "wget $wgetopt -Onsis/System.dll http://qgis.org/downloads/System.dll";
    die "download of System.dll failed" if $?;
}

mkdir $packages, 0755 unless -d $packages;
chdir $packages;

system "wget $wgetopt -c http://nsis.sourceforge.net/mediawiki/images/9/9d/Untgz.zip" unless -f "Untgz.zip";
die "download of Untgz.zip failed" if $?;

system "wget $wgetopt -O setup.ini -c $base_url$archpath/$ininame";
die "download of setup.ini failed" if $?;

# Create structures ----------------------------------------------------------

my @root_packages = ("edugis-qgis");

# unless(@ARGV) {
#     print "Defaulting to qgis-full package...\n" if $verbose;
#     push @root_packages, "qgis-full";
# } else {
#     push @root_packages, @ARGV;
# }

# if(-f "../addons/bin/NCSEcw4_RO.dll") {
#     print "Enabling ECW support...\n" if $verbose;
#     push @root_packages, "gdal-ecw";
# }

my ($dep_ref, $file_ref, $file_type_ref, $lic_ref, $sdesc_ref, $pkgs_ref, $lic_arr_ref, $desc_ref) 
  = Common::get_structures($base_path, "$base_path/$packages/setup.ini", \@root_packages, $verbose);

my %dep = %$dep_ref;
my %file = %$file_ref;
my %file_type = %$file_type_ref;
my %lic = %$lic_ref;
my %sdesc = %$sdesc_ref;
my %pkgs = %$pkgs_ref;
my @lic = @$lic_arr_ref;
my @desc = @$desc_ref;

# ----------------------------------------------------------------------------

foreach my $p ( keys %pkgs ) {
    my @f;
    unless( exists $file{$p} ) {
        print "No file for package $p found.\n" if $verbose;
        next;
    }

    unless (exists $file_type{$p} && $file_type{$p} eq "local") {
        push @f, "$base_url/$file{$p}";
        for my $f (@f) {
            $f =~ s/\/\.\//\//g;
            my($file) = $f =~ /([^\/]+)$/;
            next if -f $file;
            print "Downloading $file [$f]...\n" if $verbose;
            system "wget $wgetopt -c $f";
            die "download of $f failed" if $?;
        }
    } else {
        push @f, "$file{$p}";
        for my $f (@f) {
            my $src = "$base_path/assets/$packages/$f";
            my $dst = "$f";
            print "Copying of $src to $dst...\n" if $verbose;
            copy $src, $dst;
            die "copying of $src failed" if $?;
        }
    }
}

chdir "..";