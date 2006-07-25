#############################################################################
##
#W  circle.gi               The CIRCLE package            Alexander Konovalov
##                                                          Panagiotis Soules
##
#H  $Id$
##
##  This file contains an implementation of circle objects and adoint groups.
##
#############################################################################

    
#############################################################################
##
#M  CircleFamily( <Fam> )
##
##  is a family $F$ in bijection with the family <Fam>,
##  but with the circle multiplication as infix multiplication.
##  That is, for $x$, $y$ in <Fam>, the product of the images in $F$ will be
##  the image of $ x + y + x \* y $.
##
##  The standard type of objects in a Circle family <F> is `<F>!.CircleType'.
##
InstallMethod(CircleFamily,
    "for a family",
    [ IsFamily ],
function( Fam )
local F;

  # create the family of circle elements
  F:= NewFamily( "CircleFamily(...)", IsCircleObject );

  if HasCharacteristic( Fam ) then
    SetCharacteristic( F, Characteristic( Fam ) );
  fi;

  # store the type of objects in the image
  F!.CircleType:= NewType( F, IsDefaultCircleObject );

  # Return the circle family
  return F;
end );


#############################################################################
##
#M  CircleObject( <obj> )
##
##  Let <obj> be a ring element. Then `CircleObject( <obj> )' is the
##  corresponding circle object. If <obj> lies in the family <F>,
##  then `CircleObject( <obj> )' lies in the family CircleFamily( <F> )
##  (see~"CircleFamily").
##
InstallMethod( CircleObject,
    "for a ring element",
    [ IsRingElement ],
    obj -> Objectify( CircleFamily( FamilyObj( obj ) )!.CircleType,
                      [ Immutable( obj ) ] ) );


#############################################################################
##
#O  UnderlyingRingElement( <obj> )
##
##  Let <obj> be a circle object. Then `UnderlyingRingElement( <obj> )' 
##  is the corresponding ring element. 
##
InstallMethod( UnderlyingRingElement,
    "for a circle object", 
    [ IsCircleObject],
    obj -> obj![1] );

                      
#############################################################################
##
#M  PrintObj( <obj> )
##
InstallMethod( PrintObj,
    "for object in `IsCircleObject'",
    [ IsDefaultCircleObject ],
    function( obj )
    Print( "CircleObject( ", obj![1], " )" );
    end );
    

#############################################################################
##
#M  \=( <x>, <y> )  . .  . . . . . . . . . . . . . . . for two circle objects
##
InstallMethod( \=,
    "for two objects in `IsCircleObject'",
    IsIdenticalObj,
    [ IsDefaultCircleObject, IsDefaultCircleObject ],
    function( a, b )
    return a![1] = b![1];
    end );


#############################################################################
##
#M  \<( <x>, <y> )  . .  . . . . . . . . . . . . . . . for two circle objects
##
InstallMethod( \<,
    "for two objects in `IsCircleObject'",
    IsIdenticalObj,
    [ IsDefaultCircleObject, IsDefaultCircleObject ],
    function( a, b )
    return a![1] < b![1];
    end );


#############################################################################
##
#M  \*( <x>, <y> )  . .  . . . . . . . . . . . . . . . for two circle objects
##
InstallMethod( \*,
    "for two objects in `IsCircleObject'",
    IsIdenticalObj,
    [ IsDefaultCircleObject, IsDefaultCircleObject ],
    function( a, b )
    return CircleObject( a![1] + b![1] + a![1]*b![1] );
    end );


#############################################################################
##
#M  OneOp( <circle_obj> )  . . . . . . . . . . . . . . .  for a circle object
##
InstallMethod( OneOp,
    "for an object in `IsCircleObject'",
    [ IsDefaultCircleObject ],
    a -> CircleObject( Zero( a![1] ) ) );


#############################################################################
##
#M  InverseOp( <circle_obj> )  . . . . . . . . . . . . .  for a circle object
##
InstallMethod( InverseOp,
    "for an object in `IsCircleObject'",
    [ IsDefaultCircleObject ],
    function( a )
    local x;
    x := Inverse( One( a![1] ) + a![1] );
    if x = fail then
      return fail;
    else
      return CircleObject( -1 * a![1] * x );
    fi;
    end );


#############################################################################
##
#M  IsUnit( <R>, <circle_obj> )
##
InstallMethod( IsUnit,
    "for a circle object in the given ring",
    [ IsRing, IsDefaultCircleObject ],
    function( R, a )
    return IsUnit( R, One( a![1] ) + a![1] );
    end );


#############################################################################
##
#M  IsUnit( <circle_obj> )
##
InstallOtherMethod( IsUnit,
    "for a circle object in the default ring",
    [ IsDefaultCircleObject ],
    a -> IsUnit( One( a![1] ) + a![1] ) );


#############################################################################
##
#M  IsCircleUnit( <R>,<obj> )
##
InstallMethod( IsCircleUnit,
    "for a ring element in the given ring",
    [ IsRing, IsRingElement ],
    function( R, a )
    return IsUnit( R, One( a ) + a );
    end );


#############################################################################
##
#M  IsCircleUnit( <obj> )
##
InstallOtherMethod( IsCircleUnit,
    "for a ring element in the default ring",
    [ IsRingElement ],
    a -> IsUnit( One( a ) + a ) );


#############################################################################
##
#M  AdjointGroup( <R> )
##
##  Let R be an associative ring, not necessarily with a unit element. The 
##  set of all elements of R forms a monoid with neutral element 0 from R 
##  under the operation r * s = r + s + rs for all r and s of R. This monoid
##  is calles the adjoint semigroup of R and is denoted R^ad. The group of 
##  all invertible elements of this monoid is called the adjoint group of R 
##  and is denoted by R^*.
##
##  If R is a radical algebra, that all its elements form a group with
##  respect to the circle multiplication x*y = x + y + xy. Therefore
##  its adjoint group coincides with R elementwise. We use this condition
##  to determine whether the chosen set of generators is enough to generate
##  the adjoint group. Note that the returned group not necessary has the
##  minimal generating set.
##
##  (I tested also the loop over all elements of R instead of the random
##  selection. In my examples this was less efficient. But whether it is
##  better to avoid randomness in the general method ???).
##
##  If R has a unity 1, then 1+R^ad coincides with the multiplicative 
##  semigroup R^mult of R, and the map r -> 1+r with r in R is an isomorphism 
##  from R^ad onto R^mult. Similarly, 1+R^* coincides with the unit group of
##  R, which we denote U(R), and the map r -> 1+r with r in R is an 
##  isomorphism from R^* onto U(R).
##
##  If R is neither radical algebra nor ring with unity, then we compute
##  all circle units of R, and then form a group of circle units, using
##  the approach similar to the case of a radical algebra (this will work
##  only for rings for which enummeration of all elements is feasible)
##
InstallMethod(AdjointGroup,
    "for a ring",
    [ IsRing ],
    function( R )

    local CircleUnits, G, h, h1, H;

    if not IsFinite( R ) then
      Error("Adjoint groups for infinite associative rings are ",
            "not implemented yet !!!");
    fi;

    if not IsAssociative( R ) then
      # To enforce the associativity test for rings of the form 
      # Ring( [ ZmodnZObj( 2, 8 ) ] );
      Error("The ring <R> is non-associative !!!");
    fi;
    
    if IsRingWithOne(R) then
    
      Error("Adjoint groups for associative rings with one ",
            "are not implemented !!! \n",
            "Use the unit group Units( R ) ",
            "which is isomorphic to the adjoint group !!!");
    
    else
    
      if IsAlgebra( R ) and R = RadicalOfAlgebra( R ) then
        Info( InfoCircle, 1, "Circle : <R> is a radical algebra, all elements are circle units");
        CircleUnits := R;
      else
        Info( InfoCircle, 1, "Circle : <R> is not a radical algebra, computing circle units ...");
        CircleUnits := [ ];
	for h in R do
	  h1 := CircleObject( h )^-1;
	  if h1 <> fail then
	    if UnderlyingRingElement( h1 ) in R then
	      Add( CircleUnits, h );
	    fi;
	  fi;
        od;
      fi;

      Info( InfoCircle, 1, "Circle : searching generators for adjoint group ...");

      repeat
        h := Random( CircleUnits );
      until h <> Zero( R );

      G := Group( CircleObject( h ) );

      while Size( G ) < Size( CircleUnits ) do
        h := Random( CircleUnits );
        if h <> Zero( R ) then
          H := ClosureGroup( G, CircleObject( h ) );
          if Size( G ) < Size( H ) then
            G := H;
          fi;
	fi;
      od;

      SetUnderlyingRing( G, R );
      return G;

    fi;

    end );


#############################################################################
##
#E
##