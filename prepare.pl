use strict;
use warnings;

use Cwd qw(abs_path);
use FindBin;
use Data::Dumper;

my $base_path = abs_path($FindBin::Bin);

require("$base_path/Common.pm");

my $verbose = 1;
my $packages = "packages";
# my $arch = "x86";
# my $root = "http://download.osgeo.org/osgeo4w";
# my $ininame = "setup.ini";
my $unpacked = "unpacked";
my $wgetopt = $verbose ? "" : "-q";
my $taropt = "v" x $verbose;
my $keep = 0;

my $major = 2;
my $minor = 1;
my $patch = 0;
my $binary = 0;
my $version = "$major.$minor.$patch";

my $shortname = "qgis";

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

if( -d $unpacked ) {
    unless( $keep ) {
        print "Removing $unpacked directory\n" if $verbose;
        system "rm -rf $unpacked";
    } else {
        print "Keeping $unpacked directory\n" if $verbose;
    }
}

unless( -d $unpacked ) {
    mkdir "$unpacked", 0755;
    mkdir "$unpacked/bin", 0755;
    mkdir "$unpacked/etc", 0755;
    mkdir "$unpacked/etc/setup", 0755;

    # Create package database
    open O, ">$unpacked/etc/setup/installed.db";
    print O "INSTALLED.DB 2\n";

    foreach my $pn ( keys %pkgs ) {
        my $p = $file{$pn};
        unless( defined $p ) {
            print "No package found for $pn\n" if $verbose;
            next;
        }

        my ($p_file) = $p =~ /([^\/]+)$/;
        $p = "$packages/$p_file";

        unless( -r $p ) {
            print "Package $p not found.\n" if $verbose;
            next;
        }

        print O "$pn $p 0\n";

        print "Unpacking $p...\n" if $verbose;
        system "tar $taropt -C $unpacked -xjvf $p | gzip -c >$unpacked/etc/setup/$pn.lst.gz";
        die "unpacking of $p failed" if $?;
    }

    close O;

    chdir $unpacked;

    mkdir "bin", 0755;

    unless( -f "bin/nircmd.exe" ) {
        unless( -f "../$packages/nircmd.zip" ) {
            system "cd ../$packages; wget $wgetopt -c http://www.nirsoft.net/utils/nircmd.zip";
            die "download of nircmd.zip failed" if $?;
        }

        mkdir "apps", 0755;
        mkdir "apps/nircmd", 0755;
        system "cd apps/nircmd; unzip ../../../$packages/nircmd.zip && mv nircmd.exe nircmdc.exe ../../bin";
        die "unpacking of nircmd failed" if $?;
    }

    if( -d "../addons" ) {
        print " Including addons...\n" if $verbose;
        system "tar -C ../addons -cf - . | tar $taropt -xf -";
        die "copying of addons failed" if $?;
    }

    chdir "..";
}


# Create postinstall.bat -----------------------------------------------------

open F, ">Installer-Files/postinstall.bat";

print F "\@echo off\r\n";
print F "del postinstall.log>>postinstall.log\r\n";
print F "echo OSGEO4W_ROOT=%OSGEO4W_ROOT%>>postinstall.log 2>&1\r\n";
print F "echo OSGEO4W_STARTMENU=%OSGEO4W_STARTMENU%>>postinstall.log 2>&1\r\n";
print F "set OSGEO4W_ROOT_MSYS=%OSGEO4W_ROOT:\\=/%\r\n";
print F "if \"%OSGEO4W_ROOT_MSYS:~1,1%\"==\":\" set OSGEO4W_ROOT_MSYS=/%OSGEO4W_ROOT_MSYS:~0,1%/%OSGEO4W_ROOT_MSYS:~3%\r\n";
print F "echo OSGEO4W_ROOT_MSYS=%OSGEO4W_ROOT_MSYS%>>postinstall.log 2>&1\r\n";
print F "PATH %OSGEO4W_ROOT%\\bin;%PATH%>>postinstall.log 2>&1\r\n";
print F "cd %OSGEO4W_ROOT%>>postinstall.log 2>&1\r\n";

chdir $unpacked;
for my $p (<etc/postinstall/*.bat>) {
    $p =~ s/\//\\/g;
    my($dir,$file) = $p =~ /^(.+)\\([^\\]+)$/;

    print F "echo Running postinstall $file...\r\n";
    print F "%COMSPEC% /c $p>>postinstall.log 2>&1\r\n";
    print F "ren $p $file.done>>postinstall.log 2>&1\r\n";
}
chdir "..";

print F "ren postinstall.bat postinstall.bat.done\r\n";

close F;

# ----------------------------------------------------------------------------


# Create preremove.bat -------------------------------------------------------

open F, ">Installer-Files/preremove.bat";

print F "\@echo off\r\n";
print F "del preremove.log>>preremove.log\r\n";
print F "echo OSGEO4W_ROOT=%OSGEO4W_ROOT%>>preremove.log 2>&1\r\n";
print F "echo OSGEO4W_STARTMENU=%OSGEO4W_STARTMENU%>>preremove.log 2>&1\r\n";
print F "set OSGEO4W_ROOT_MSYS=%OSGEO4W_ROOT:\\=/%\r\n";
print F "if \"%OSGEO4W_ROOT_MSYS:~1,1%\"==\":\" set OSGEO4W_ROOT_MSYS=/%OSGEO4W_ROOT_MSYS:~0,1%/%OSGEO4W_ROOT_MSYS:~3%\r\n";
print F "echo OSGEO4W_ROOT_MSYS=%OSGEO4W_ROOT_MSYS%>>preremove.log 2>&1\r\n";
print F "PATH %OSGEO4W_ROOT%\\bin;%PATH%>>preremove.log 2>&1\r\n";
print F "cd %OSGEO4W_ROOT%>>preremove.log 2>&1\r\n";

chdir $unpacked;
for my $p (<etc/preremove/*.bat>) {
    $p =~ s/\//\\/g;
    my($dir,$file) = $p =~ /^(.+)\\([^\\]+)$/;

    print F "echo Running preremove $file...\r\n";
    print F "%COMSPEC% /c $p>>preremove.log 2>&1\r\n";
    print F "ren $p $file.done>>preremove.log 2>&1\r\n";
}
chdir "..";

print F "ren preremove.bat preremove.bat.done\r\n";

close F;

# ----------------------------------------------------------------------------

unless(-d "untgz") {
    system "unzip $packages/Untgz.zip";
    die "unpacking Untgz.zip failed" if $?;
}