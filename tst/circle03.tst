# Circle, chapter 3
# [ ".//doc/funct.xml", 41, 46 ]

gap> a := CircleObject( 2 );
CircleObject( 2 )

# [ ".//doc/funct.xml", 57, 64 ]

gap> a := CircleObject( 2 );
CircleObject( 2 )
gap> UnderlyingRingElement( a );    
2

# [ ".//doc/funct.xml", 87, 97 ]

gap> IsCircleObject( 2 ); IsCircleObject( CircleObject( 2 ) );            
false
true
gap> IsMultiplicativeElementWithInverse( CircleObject( 2 ) );
true
gap> IsCircleObjectCollection( [ CircleObject(0), CircleObject(2) ] );
true

# [ ".//doc/funct.xml", 117, 124 ]

gap> IsPositionalObjectOneSlotRep( CircleObject( 2 ) );
true
gap> IsDefaultCircleObject( CircleObject( 2 ) );                          
true

# [ ".//doc/funct.xml", 140, 145 ]

gap> FamilyObj( CircleObject ( 2 ) ) = CircleFamily( FamilyObj( 2 ) );
true

# [ ".//doc/funct.xml", 164, 173 ]

gap> One( CircleObject( 5 ) );
CircleObject( 0 )
gap> One( CircleObject( 5 ) ) = CircleObject( Zero( 5 ) );
true
gap> One( CircleObject( [ [ 1, 1 ],[ 0, 1 ] ] ) );
CircleObject( [ [ 0, 0 ], [ 0, 0 ] ] )

# [ ".//doc/funct.xml", 191, 200 ]

gap> CircleObject( -2 )^-1;                        
CircleObject( -2 )
gap> CircleObject( 2 )^-1; 
CircleObject( -2/3 )
gap> CircleObject( -2 )*CircleObject( -2 )^-1;
CircleObject( 0 )

# [ ".//doc/funct.xml", 202, 213 ]

gap> m := CircleObject( [ [ 1, 1 ], [ 0, 1 ] ] );   
CircleObject( [ [ 1, 1 ], [ 0, 1 ] ] )
gap> m^-1;    
CircleObject( [ [ -1/2, -1/4 ], [ 0, -1/2 ] ] )
gap> m * m^-1;
CircleObject( [ [ 0, 0 ], [ 0, 0 ] ] )
gap> CircleObject( [ [ 0, 1 ], [ 1, 0 ] ] )^-1; 
fail

# [ ".//doc/funct.xml", 228, 242 ]

gap> IsUnit( Integers, CircleObject( -2 ) );
true
gap> IsUnit( Integers, CircleObject( 2 ) ); 
false
gap> IsUnit( Rationals, CircleObject( 2 ) );        
true
gap> IsUnit( ZmodnZ(8), CircleObject( ZmodnZObj(2,8) ) );
true
gap> m := CircleObject( [ [ 1, 1 ],[ 0, 1 ] ] );;
gap> IsUnit( FullMatrixAlgebra( Rationals, 2 ), m );
true

# [ ".//doc/funct.xml", 249, 260 ]

gap> IsUnit( CircleObject( -2 ) );
true
gap> IsUnit( CircleObject( 2 ) ); 
false
gap> IsUnit( CircleObject( ZmodnZObj(2,8) ) );
true
gap> IsUnit( CircleObject( [ [ 1, 1 ],[ 0, 1 ] ] ) );                                    
false

# [ ".//doc/funct.xml", 276, 291 ]

gap> IsCircleUnit( Integers, -2 );
true
gap> IsCircleUnit( Integers, 2 ); 
false
gap> IsCircleUnit( Rationals, 2 );          
true
gap> IsCircleUnit( ZmodnZ(8), ZmodnZObj(2,8) ); 
true
gap> m := [ [ 1, 1 ],[ 0, 1 ] ];                
[ [ 1, 1 ], [ 0, 1 ] ]
gap> IsCircleUnit( FullMatrixAlgebra(Rationals,2), m );
true

# [ ".//doc/funct.xml", 296, 307 ]

gap> IsCircleUnit( -2 );                               
true
gap> IsCircleUnit( 2 ); 
false
gap> IsCircleUnit( ZmodnZObj(2,8) );           
true
gap> IsCircleUnit( [ [ 1, 1 ],[ 0, 1 ] ] ); 
false

# [ ".//doc/funct.xml", 331, 338 ]

gap> R:=Ring( [ ZmodnZObj(2,8) ] );
<ring with 1 generators>
gap> S:=AdjointSemigroup(R);
<monoid with 4 generators>

# [ ".//doc/funct.xml", 391, 408 ]

gap> x:=[ [ 0, 1, 0 ],
>         [ 0, 0, 1 ],
>         [ 0, 0, 0 ] ];;
gap> R := Algebra( GF(2), [ One(GF(2))*x ] );  
<algebra over GF(2), with 1 generators>
gap> RadicalOfAlgebra( R ) = R;
true
gap> Dimension(R);
2
gap> G := AdjointGroup( R );;
gap> Size( R ) = Size( G );
true
gap> StructureDescription( G );
"C4"

# [ ".//doc/funct.xml", 417, 436 ]

gap> x:=[ [ 0, 1, 0 ],
>         [ 0, 0, 0 ],     
>         [ 0, 0, 0 ] ];;
gap> y:=[ [ 0, 0, 0 ],     
>         [ 0, 0, 1 ],  
>         [ 0, 0, 0 ] ];;
gap> R := Algebra( GF(2), One(GF(2))*[x,y] );  
<algebra over GF(2), with 2 generators>
gap> RadicalOfAlgebra(R) = R;                
true
gap> Dimension(R);
3
gap> G := AdjointGroup( R );
<group of size 8 with 2 generators>
gap> StructureDescription( G );
"D8"

# [ ".//doc/funct.xml", 452, 466 ]

gap> R := Ring( [ ZmodnZObj(2,8) ] );
<ring with 1 generators>
gap> G := AdjointGroup( R );
<group of size 4 with 2 generators>
gap> StructureDescription( G );
"C2 x C2"
gap> R := Ring( [ ZmodnZObj(2,256) ] );   
<ring with 1 generators>
gap> G := AdjointGroup( R );;
gap> StructureDescription( G );
"C64 x C2"

# [ ".//doc/funct.xml", 474, 487 ]

gap> R := Ring( [ ZmodnZObj(2,256) ] );  
<ring with 1 generators>
gap> S := AdjointSemigroup( R );
<monoid with 128 generators>
gap> H := GreensHClassOfElement(S,One(S));
<Green's H-class: <object>>
gap> G:=AsGroup(H);
<group of size 128 with 2 generators>
gap> StructureDescription(G);
"C64 x C2"

# [ ".//doc/funct.xml", 497, 509 ]

gap> R := Ring( [ ZmodnZObj(2,256) ] );   
<ring with 1 generators>
gap> AdjointGroup(R);;
gap> R := Ring( [ ZmodnZObj(2,256) ] );
<ring with 1 generators>
gap> S:=AdjointSemigroup(R); 
<monoid with 128 generators>
gap> AsGroup(GreensHClassOfElement(S,One(S))); 
<group of size 128 with 2 generators>

# [ ".//doc/funct.xml", 528, 542 ]

gap> LoadPackage( "laguna", false );
true
gap> FG := GroupRing( GF(2), DihedralGroup(8) );
<algebra-with-one over GF(2), with 3 generators>
gap> R := AugmentationIdeal( FG );;
gap> G := AdjointGroup( R );;
gap> IdGroup( G );
[ 128, 170 ]
gap> IdGroup( Units( FG ) );
#I  LAGUNA package: Computing the unit group ...
[ 128, 170 ]

# [ ".//doc/funct.xml", 551, 568 ]

gap> Size( AdjointGroup( GroupRing( GF(2), DihedralGroup(8) ) ) );

WARNING: usage of AdjointGroup for associative ring <R> with one!!! 
In this case the adjoint group is isomorphic to the unit group 
Units(<R>), which possibly may be computed faster!!! 

128
gap> Size( AdjointGroup( Integers mod 11 ) );                  

WARNING: usage of AdjointGroup for associative ring <R> with one!!! 
In this case the adjoint group is isomorphic to the unit group 
Units(<R>), which possibly may be computed faster!!! 

10

# [ ".//doc/funct.xml", 593, 605 ]

gap> SetInfoLevel( InfoCircle, 1 );
gap> SetInfoLevel(InfoCircle,1);
gap> R := Ring( [ ZmodnZObj(2,8) ]);
<ring with 1 generators>
gap> G := AdjointGroup( R );
#I  Circle : <R> is not a radical algebra, computing circle units ...
#I  Circle : searching generators for adjoint group ...
<group of size 4 with 2 generators>
gap> SetInfoLevel( InfoCircle, 0 );

