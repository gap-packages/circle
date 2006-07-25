#############################################################################
##
#W  circle.gd               The CIRCLE package            Alexander Konovalov
##                                                          Panagiotis Soules
##
#H  $Id$
##
##  Let R be an associative ring, not necessarily with a unit element. The
##  set of all elements of R forms a monoid with neutral element 0 from R
##  under the operation r * s = r + s + rs for all r and s of R. This monoid
##  is called the adjoint semigroup of R and is denoted R^ad. The group of
##  all invertible elements of this monoid is called the adjoint group of R
##  and is denoted by R^*.
##
##  This file contains declarations for circle objects and adoint groups.
##
#############################################################################


#############################################################################
##
##  InfoCircle
##  
##  We declare new Info class for Circle algorithms. 
##  It has 2 levels - 0 (default) and 1
##  To change Info level to k, use command SetInfoLevel(InfoCircle, k)
DeclareInfoClass("InfoCircle");


#############################################################################
##
#C  IsCircleObject( <obj> )
#C  IsCircleObjectCollection( <obj> )
##
##  An object lies in `IsCircleObject' if and only if it lies in a family
##  constructed by `CircleFamily'. Since circle objects can be multiplied
##  via * with elements in their family, and we want to have operations
##  `One' and `Inverse' (which may return `fail' for a given circle object)
##  to study groups generated by circle objects, circle objects will belong
##  to the category `IsMultiplicativeElementWithInverse'.
##
DeclareCategory( "IsCircleObject", IsMultiplicativeElementWithInverse );

DeclareCategoryCollections( "IsCircleObject" );

#############################################################################
##
#A  CircleFamily( <Fam> )
##
##  is a family $F$ in bijection with the family <Fam>,
##  but with the circle multiplication as infix multiplication.
##  That is, for $x$, $y$ in <Fam>, the product of the images in $F$ will be
##  the image of $ x + y + x \* y $.
##
##  The standard type of objects in a Lie family <F> is `<F>!.CircleType'.
##
DeclareAttribute( "CircleFamily", IsFamily );


#############################################################################
##
#A  CircleObject( <obj> )
##
##  Let <obj> be a ring element. Then `CircleObject( <obj> )' is the
##  corresponding circle object. If <obj> lies in the family <F>,
##  then `CircleObject( <obj> )' lies in the family CircleFamily( <F> )
##  (see~"CircleFamily").
##
DeclareAttribute( "CircleObject", IsRingElement );


#############################################################################
##
#O  UnderlyingRingElement( <obj> )
##
##  Let <obj> be a circle object. Then `UnderlyingRingElement( <obj> )' 
##  is the corresponding ring element. 
##
DeclareOperation("UnderlyingRingElement", [ IsCircleObject] );


#############################################################################
##
#R  IsPositionalObjectOneSlotRep( <obj> )
##
DeclareRepresentation( "IsPositionalObjectOneSlotRep",
    IsPositionalObjectRep, [ 1 ] );

DeclareSynonym( "IsDefaultCircleObject",
    IsCircleObject and IsPositionalObjectOneSlotRep );

#############################################################################
##
#A  IsUnit( <R>, <circle_obj> )
##
##  we declare separate method for IsUnit for circle objects because
##  they are not ring elements for which this method is already declared
##
DeclareOperation( "IsUnit", [ IsRing, IsDefaultCircleObject ] );

    
#############################################################################
##
#A  IsCircleUnit( <obj> )
##
##  Let <obj> be an element of the ring R. Then `IsCircleUnit( <obj> )'
##  determines whether it is invertible with respect to the circle
##  multilpication x+y+xy. This is equivalent to the condition that 1+obj
##  is a unit in R with respect to the ordinary multiplication.
##
DeclareOperation( "IsCircleUnit", [ IsRing, IsRingElement ] );


#############################################################################
##
#A  AdjointGroup( <R> )
##
DeclareAttribute( "AdjointGroup", IsRing );


#############################################################################
##
#E
##