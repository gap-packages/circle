# Circle, chapter 2
# [ ".//doc/objects.xml", 18, 29 ]

gap> CircleMultiplication := function(a,b)
>      return a+b+a*b;
>    end;
function( a, b ) ... end
gap> CircleMultiplication(2,3); 
11
gap> CircleMultiplication( ZmodnZObj(2,8), ZmodnZObj(5,8) );      
ZmodnZObj( 1, 8 )

# [ ".//doc/objects.xml", 35, 42 ]

gap> CircleMultiplication( 3, ZmodnZObj(3,8) );
ZmodnZObj( 7, 8 )
gap> CircleMultiplication( [1], [2,3] );
[ 5, 5 ]

# [ ".//doc/objects.xml", 50, 63 ]

gap> DeclareOperation( "BetterCircleMultiplication",                             
>      [IsRingElement,IsRingElement] );
gap> InstallMethod( BetterCircleMultiplication,
>      IsIdenticalObj,
>      [IsRingElement,IsRingElement],  
>      CircleMultiplication );
gap> BetterCircleMultiplication(2,3);
11
gap> BetterCircleMultiplication( ZmodnZObj(2,8), ZmodnZObj(5,8) );
ZmodnZObj( 1, 8 )

# [ ".//doc/objects.xml", 85, 90 ]

gap> CircleObject( 2 ) * CircleObject( 3 );                       
CircleObject( 11 )

# [ ".//doc/objects.xml", 106, 111 ]

gap> DeclareCategory( "IsMyCircleObject", 
> IsAssociativeElement and IsMultiplicativeElementWithInverse );

# [ ".//doc/objects.xml", 119, 123 ]

gap> DeclareCategoryCollections( "IsMyCircleObject" );

# [ ".//doc/objects.xml", 134, 141 ]

gap> DeclareRepresentation( "IsMyPositionalObjectOneSlotRep",
>     IsPositionalObjectRep, [ 1 ] );
gap> DeclareSynonym( "IsMyDefaultCircleObject",
>     IsMyCircleObject and IsMyPositionalObjectOneSlotRep );

# [ ".//doc/objects.xml", 153, 157 ]

gap> DeclareAttribute( "MyCircleFamily", IsFamily );

# [ ".//doc/objects.xml", 162, 180 ]

gap> InstallMethod( MyCircleFamily,
>     "for a family",
>     [ IsFamily ],
>     function( Fam )
>     local F;
>   # create the family of circle elements
>   F:= NewFamily( "MyCircleFamily(...)", IsMyCircleObject );
>   if HasCharacteristic( Fam ) then
>     SetCharacteristic( F, Characteristic( Fam ) );
>   fi;
>   # store the type of objects in the output
>   F!.MyCircleType:= NewType( F, IsMyDefaultCircleObject );
>   # Return the circle family
>   return F;
> end );

# [ ".//doc/objects.xml", 191, 200 ]

gap> DeclareAttribute( "MyCircleObject", IsRingElement );
gap> InstallMethod( MyCircleObject,
>     "for a ring element",
>     [ IsRingElement ],
>     obj -> Objectify( MyCircleFamily( FamilyObj( obj ) )!.MyCircleType,
>                       [ Immutable( obj ) ] ) );

# [ ".//doc/objects.xml", 206, 213 ]

gap> a:=MyCircleObject(2);
<object>
gap> a![1];
2

# [ ".//doc/objects.xml", 218, 223 ]

gap> FamilyObj( MyCircleObject ( 2 ) ) = MyCircleFamily( FamilyObj( 2 ) );
true

# [ ".//doc/objects.xml", 228, 237 ]

gap> InstallMethod( PrintObj,
>     "for object in `IsMyCircleObject'",
>     [ IsMyDefaultCircleObject ],
>     function( obj )
>     Print( "MyCircleObject( ", obj![1], " )" );
>     end );

# [ ".//doc/objects.xml", 244, 249 ]

gap> a;
MyCircleObject( 2 )

# [ ".//doc/objects.xml", 259, 269 ]

gap> DeclareAttribute("UnderlyingRingElement", IsMyCircleObject );
gap> InstallMethod( UnderlyingRingElement,
>     "for a circle object", 
>     [ IsMyCircleObject],
>     obj -> obj![1] );
gap> UnderlyingRingElement(a);
2

# [ ".//doc/objects.xml", 280, 292 ]

gap> InstallMethod( \*,
>     "for two objects in `IsMyCircleObject'",
>     IsIdenticalObj,
>     [ IsMyDefaultCircleObject, IsMyDefaultCircleObject ],
>     function( a, b )
>     return MyCircleObject( a![1] + b![1] + a![1]*b![1] );
>     end );
gap> MyCircleObject(2)*MyCircleObject(3);
MyCircleObject( 11 )

# [ ".//doc/objects.xml", 301, 318 ]

gap> InstallMethod( \=,
>     "for two objects in `IsMyCircleObject'",
>     IsIdenticalObj,
>     [ IsMyDefaultCircleObject, IsMyDefaultCircleObject ],
>     function( a, b )
>     return a![1] = b![1];
>     end );
gap> InstallMethod( \<,
>     "for two objects in `IsMyCircleObject'",
>     IsIdenticalObj,
>     [ IsMyDefaultCircleObject, IsMyDefaultCircleObject ],
>     function( a, b )
>     return a![1] < b![1];
>     end );

# [ ".//doc/objects.xml", 325, 334 ]

gap> InstallMethod( OneOp,
>     "for an object in `IsMyCircleObject'",
>     [ IsMyDefaultCircleObject ],
>     a -> MyCircleObject( Zero( a![1] ) ) );
gap> One(a);
MyCircleObject( 0 )

# [ ".//doc/objects.xml", 338, 351 ]

gap> S:=Monoid(a);
<commutative monoid with 1 generator>
gap> One(S);
MyCircleObject( 0 )
gap> S:=Monoid( MyCircleObject( ZmodnZObj( 2,8) ) );
<commutative monoid with 1 generator>
gap> Size(S);
2
gap> AsList(S);
[ MyCircleObject( ZmodnZObj( 0, 8 ) ), MyCircleObject( ZmodnZObj( 2, 8 ) ) ]

# [ ".//doc/objects.xml", 359, 378 ]

gap> InstallMethod( InverseOp,
>     "for an object in `IsMyCircleObject'",
>     [ IsMyDefaultCircleObject ],
>     function( a )
>     local x;
>     x := Inverse( One( a![1] ) + a![1] );
>     if x = fail then
>       return fail;
>     else
>       return MyCircleObject( -a![1] * x );
>     fi;
>     end );
gap> MyCircleObject(-2)^-1;                
MyCircleObject( -2 )
gap> MyCircleObject(2)^-1; 
MyCircleObject( -2/3 )

# [ ".//doc/objects.xml", 383, 396 ]

gap> Group( MyCircleObject(2) );;
#I  default `IsGeneratorsOfMagmaWithInverses' method returns `true' for
[ MyCircleObject( 2 ) ]
gap> G:=Group( [MyCircleObject( ZmodnZObj( 2,8 ) )  ]);;
#I  default `IsGeneratorsOfMagmaWithInverses' method returns `true' for
[ MyCircleObject( ZmodnZObj( 2, 8 ) ) ]
gap> Size(G);
2
gap> AsList(G);
[ MyCircleObject( ZmodnZObj( 0, 8 ) ), MyCircleObject( ZmodnZObj( 2, 8 ) ) ]

