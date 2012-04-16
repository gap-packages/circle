LoadPackage("circle");

dir := DirectoriesPackageLibrary("circle","tst");

testsfiles := [ 
"circle02.tst",
"circle03.tst",
"circle04.tst",
];

Print("=================================================================\n");
for ff in testsfiles do
  fn := Filename(dir, ff );
  Print("*** TESTING ", fn, "\n");
  ReadTest( fn );
  Print("=================================================================\n");
od;  
Print("*** FINISHED CIRCLE PACKAGE TESTS\n");
Print("=================================================================\n");