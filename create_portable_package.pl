use strict;
use warnings;

$|++;

use Cwd qw(abs_path);
use FindBin;
use Data::Dumper;

use File::Copy::Recursive qw(fcopy dircopy);
use File::Path qw(make_path remove_tree);

my $base_path = abs_path($FindBin::Bin);

my $container_dir = "$base_path/out/portable/EduGIS";
my $qgis_dir_name = ".qgis";


print "Create container directory... ";
remove_tree($container_dir);
make_path($container_dir);
print "Done.\n";


print "Copy QGIS files into container... ";
dircopy("$base_path/unpacked", "$container_dir/$qgis_dir_name") or die "Failed.\n";
print "Done.\n";


print "Clean up QGIS dir... ";
remove_tree("$container_dir/$qgis_dir_name/etc/postinstall") or die "Failed.\n";
remove_tree("$container_dir/$qgis_dir_name/etc/preremove") or die "Failed.\n";
print "Done.\n";


print "Copy bootstrap scripts... ";
dircopy("$base_path/assets/portable/bootstrap", "$container_dir/$qgis_dir_name/etc/bootstrap") or die "Failed.\n";
fcopy("$base_path/assets/portable/edugis-qgis-launcher.cmd", "$container_dir/Launch EduGIS Desktop.cmd") or die "Failed.\n";
dircopy("$base_path/assets/config", "$container_dir/$qgis_dir_name/.config") or die "Failed.\n";
dircopy("$base_path/assets/plugins/edugis", "$container_dir/$qgis_dir_name/apps/edugis-qgis/python/plugins/edugis") or die "Failed.\n";

dircopy("$base_path/assets/plugins/mmqgis", "$container_dir/$qgis_dir_name/apps/edugis-qgis/python/plugins/mmqgis") or die "Failed.\n";
dircopy("$base_path/assets/plugins/tablemanager", "$container_dir/$qgis_dir_name/apps/edugis-qgis/python/plugins/tablemanager") or die "Failed.\n";
dircopy("$base_path/assets/plugins/openlayers", "$container_dir/$qgis_dir_name/apps/edugis-qgis/python/plugins/openlayers") or die "Failed.\n";
print "Done.\n";


print "Copy Qt styles... ";
make_path("$container_dir/$qgis_dir_name/apps/Qt4/plugins/styles");
fcopy("$base_path/assets/styles/edugis-style.dll", "$container_dir/$qgis_dir_name/apps/Qt4/plugins/styles") or die "Failed.\n";
print "Done.\n";

print "Hack. Create package 'expressions'... ";
make_path("$container_dir/$qgis_dir_name/.config/python/expressions");
print "Done.\n";

print "Copy svg icons... ";
dircopy("$base_path/assets/icons/mapbox-maki", "$container_dir/$qgis_dir_name/apps/edugis-qgis/svg/mapbox-maki") or die "Failed.\n";
print "Done.\n";

#print "Remove attribute readonly... ";
print "Fix permissions... ";
system "attrib -r $container_dir\\*.* /s";
system "cd $container_dir && icacls * /t  /grant Everyone:F";
# icacls * /t  /grant Everyone:F
print "Done.\n";
