#!/bin/env perl
open (LS,"/bin/ls *.out|");
while ($filename = <LS>) {
    chop $filename;
    @field = split(/\./, $filename);
    $root = @field[0];
    $oldname = "$root.dat.out";
    $newname = "$root.dat";
    print "Copying $oldname to $newname\n";
    system("cp $oldname $newname");
}
exit
