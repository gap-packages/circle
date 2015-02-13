#############################################################################
##
#W  PackageInfo.g           The CIRCLE package            Alexander Konovalov
##                                                          Panagiotis Soules
##
#############################################################################

SetPackageInfo( rec(

PackageName := "Circle",
Subtitle := "Adjoint groups of finite rings",
Version := "1.5.3",
Date := "13/02/2015",
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "1.5.3">
##  <!ENTITY RELEASEDATE "13 February 2015">
##  <!ENTITY RELEASEYEAR "2015">
##  <#/GAPDoc>

PackageWWWHome := "http://www.cs.st-andrews.ac.uk/~alexk/circle/",

ArchiveURL := Concatenation( ~.PackageWWWHome, "circle-", ~.Version ),
ArchiveFormats := ".tar.gz",

Persons := [
  rec(
    LastName      := "Konovalov",
    FirstNames    := "Alexander",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "alexk@mcs.st-andrews.ac.uk",
    WWWHome       := "http://www.cs.st-andrews.ac.uk/~alexk/",
    PostalAddress := Concatenation( [
                     "School of Computer Science\n",
                     "University of St Andrews\n",
                     "Jack Cole Building, North Haugh,\n",
                     "St Andrews, Fife, KY16 9SX, Scotland" ] ),
    Place         := "St Andrews",
    Institution   := "University of St Andrews"
     ),
  rec(
    LastName := "Soules",
    FirstNames := "Panagiotis",
    IsAuthor := true,
    IsMaintainer := false,
    Email := "psoules@math.uoa.gr",
    PostalAddress := Concatenation( [
                     "Panepistimioupolis\n",
                     "GR-15784, Athens, Greece" ] ),
    Place         := "Athens",
    Institution   := "National and Capodistrian University of Athens"              
     )
],

Status := "accepted",
CommunicatedBy := "Leonard Soicher (QMUL)",
AcceptDate := "01/2008",

README_URL := 
  Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := 
  Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
  
AbstractHTML := "The <span class=\"pkgname\">Circle</span> package provides functionality for computations in adjoint groups of finite associative rings. It allows to construct circle objects that will respect the circle multiplication r*s=r+s+rs, create multiplicative groups, generated by such objects, and compute groups of elements, invertible with respect to this operation. Also it may serve as an example of extending the &GAP; system with new multiplicative objects.",
                  
PackageDoc := rec(
  BookName := "Circle",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile := "doc/manual.pdf",
  SixFile := "doc/manual.six",
  LongTitle := "Adjoint groups of finite rings",
  Autoload := true
),

Dependencies := rec(
  GAP := ">=4.5",
  NeededOtherPackages := [ ["GAPDoc", ">= 1.5.1"] ],
  SuggestedOtherPackages := [],
  ExternalConditions := []
),

AvailabilityTest := ReturnTrue,
Autoload := false,
TestFile := "tst/testall.g",

Keywords := ["circle multiplication", "star multiplication", 
             "adjoint semigroup", "adjoint group", "radical algebra"]
));
