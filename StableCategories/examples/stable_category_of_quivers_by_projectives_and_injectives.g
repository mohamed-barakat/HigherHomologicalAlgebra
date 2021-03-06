LoadPackage( "StableCategories" );
LoadPackage( "DerivedCategories" ); # This is needed to add homomorphism structure to quiver reps
LoadPackage( "RingsForHomalg" );

field := Rationals;;

quiver := RightQuiver( "q(4)[x0:1->2,x1:1->2,x2:1->2,x3:1->2,y0:2->3,y1:2->3,y2:2->3,y3:2->3,z0:3->4,z1:3->4,z2:3->4,z3:3->4]" );;
Qq := PathAlgebra( field, quiver );;

# End( O(0) ⊕ O(1) ⊕ O(2) ⊕ O(3) )
#
A := QuotientOfPathAlgebra(
  Qq,
  [ Qq.x0 * Qq.y1 - Qq.x1 * Qq.y0,
    Qq.x0 * Qq.y2 - Qq.x2 * Qq.y0,
    Qq.x0 * Qq.y3 - Qq.x3 * Qq.y0,
    Qq.x1 * Qq.y2 - Qq.x2 * Qq.y1,
    Qq.x1 * Qq.y3 - Qq.x3 * Qq.y1,
    Qq.x2 * Qq.y3 - Qq.x3 * Qq.y2,
    Qq.y0 * Qq.z1 - Qq.y1 * Qq.z0,
    Qq.y0 * Qq.z2 - Qq.y2 * Qq.z0,
    Qq.y0 * Qq.z3 - Qq.y3 * Qq.z0,
    Qq.y1 * Qq.z2 - Qq.y2 * Qq.z1,
    Qq.y1 * Qq.z3 - Qq.y3 * Qq.z1,
    Qq.y2 * Qq.z3 - Qq.y3 * Qq.z2
  ]
);;

# 
# End( Ω^0(0) ⊕ Ω^1(1) ⊕ Ω^2(2) ⊕ Ω^3(3) )

B := QuotientOfPathAlgebra(
  Qq,
  [ 
    Qq.x0 * Qq.y0 , Qq.y0 * Qq.z0,
    Qq.x1 * Qq.y1 , Qq.y1 * Qq.z1,
    Qq.x2 * Qq.y2 , Qq.y2 * Qq.z2,
    Qq.x3 * Qq.y3 , Qq.y3 * Qq.z3,
    Qq.x0 * Qq.y1 + Qq.x1 * Qq.y0,
    Qq.x0 * Qq.y2 + Qq.x2 * Qq.y0,
    Qq.x0 * Qq.y3 + Qq.x3 * Qq.y0,
    Qq.x1 * Qq.y2 + Qq.x2 * Qq.y1,
    Qq.x1 * Qq.y3 + Qq.x3 * Qq.y1,
    Qq.x2 * Qq.y3 + Qq.x3 * Qq.y2,
    Qq.y0 * Qq.z1 + Qq.y1 * Qq.z0,
    Qq.y0 * Qq.z2 + Qq.y2 * Qq.z0,
    Qq.y0 * Qq.z3 + Qq.y3 * Qq.z0,
    Qq.y1 * Qq.z2 + Qq.y2 * Qq.z1,
    Qq.y1 * Qq.z3 + Qq.y3 * Qq.z1,
    Qq.y2 * Qq.z3 + Qq.y3 * Qq.z2
  ]
);;

quit;
cat := CategoryOfQuiverRepresentations( B : FinalizeCategory := false );;
AddMorphismIntoColiftingObject( cat, MonomorphismIntoSomeInjectiveObject );
AddMorphismFromLiftingObject( cat, EpimorphismFromSomeProjectiveObject );
Finalize( cat );

stable_cat_by_injs := StableCategoryByColiftingStructure( cat );
stable_cat_by_projs := StableCategoryByLiftingStructure( cat );


stable_injs := ProjectionFunctor( stable_cat_by_injs );
stable_projs := ProjectionFunctor( stable_cat_by_projs );

a := RandomObject( cat, 4 );
b := RandomObject( cat, 4 );

i := Random( IndecInjRepresentations( B ) );
p := Random( IndecProjRepresentations( B ) );

Display( IsEqualForObjects( ApplyFunctor( stable_injs, i ), i/stable_cat_by_injs ) );
Display( IsEqualForObjects( ApplyFunctor( stable_projs, p ), p/stable_cat_by_projs ) );

Display( IsZero( ApplyFunctor( stable_injs, i ) ) );
Display( IsZero( ApplyFunctor( stable_projs, p ) ) );

