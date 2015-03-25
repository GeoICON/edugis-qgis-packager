package Common;

use Data::Dumper;

sub get_structures {
    my ($base_path, $reg_file, $root_packages_ref, $verbose) = @_;

    my %dep;
    my %file;
    my %file_type;
    my %lic;
    my %sdesc;
    my %pkgs;

    my $package;
    my @lines;

    open F, "$base_path/edugis_setup.ini " || die "edugis_setup.ini not found";
    push (@lines, <F>);
    close F;

    open F, $reg_file || die "registry file not found";
    push (@lines, <F>);
    close F;

    foreach (@lines) {
        chop;
        if(/^@ (\S+)/) {
            $package = $1;
            print "PACKAGE: " . $package . "\n";
        } elsif( /^requires: (.*)$/ ) {
            @{$dep{$package}} = split / /, $1;
        } elsif( /^install:\s+(\S+)\s+/) {
            $file{$package} = $1 unless exists $file{$package};
        } elsif( /^license:\s+(\S+)\s+/) {
            $lic{$package} = $1 unless exists $lic{$package};
        } elsif( /^sdesc:\s*"(.*)"\s*$/) {
            $sdesc{$package} = $1 unless exists $sdesc{$package};
        } elsif( /^type:\s*(\S+)\s*$/) {
            $file_type{$package} = $1 unless exists $file_type{$package};
        }
    }

    my @root_packages = @$root_packages_ref;
    getDeps($_, \%dep, \%pkgs, $verbose) for @root_packages;

    my @lic;
    my @desc;
    foreach my $p ( keys %pkgs ) {
        if( exists $lic{$p} ) {
            my($l) = $lic{$p} =~ /([^\/]+)$/;
            push @lic, $l;
        }
        if ( exists $sdesc{$p} ) {
            push @desc, $sdesc{$p};
        }
    }

    return (\%dep, \%file, \%file_type, \%lic, \%sdesc, \%pkgs, \@lic, \@desc);    
}


sub getDeps {
    my ($pkg, $dep_ref, $pkgs_ref, $verbose) = @_;

    return if exists $pkgs_ref->{$pkg};

    #print " Including package $pkg\n" if $verbose;
    $pkgs_ref->{$pkg} = 1;

    foreach my $p ( @{ $dep_ref->{$pkg} } ) {
        getDeps($p, $dep_ref, $pkgs_ref, $verbose);
    }
}


1;