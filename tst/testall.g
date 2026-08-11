LoadPackage( "circle" );
# Without SmallGrp, the IsomorphismGroups call in circle02.tst runs into an
# infinite recursion in the GAP library; see the comment in PackageInfo.g.
LoadPackage( "smallgrp" );

TestDirectory(DirectoriesPackageLibrary( "circle", "tst" ),
  rec(exitGAP     := true,
      testOptions := rec(compareFunction := "uptowhitespace") ) );

FORCE_QUIT_GAP(1); # if we ever get here, there was an error

