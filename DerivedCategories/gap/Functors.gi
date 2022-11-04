# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
##  Functors
##
#############################################################################

##
InstallMethod( DecompositionFunctorOfProjectiveQuiverRepresentations,
          [ IsQuiverRepresentationCategory ],
  function( cat )
    Error( "?" );
end );


# from additive subcategory of projectives to additive closure of indec projectives
functor :=
  [
    IsCapFullSubcategory,
    IsAdditiveClosureCategory,
    function( projs, add_closure )
      local reps, indec;
      reps := AmbientCategory( projs );
      if not IsQuiverRepresentationCategory( reps ) then
        return false;
      fi;
      indec := UnderlyingCategory( add_closure );
      if not HasFullSubcategoryGeneratedByIndecomposableProjectiveObjects( reps ) then
        return false;
      fi;
      if not IsIdenticalObj( indec, FullSubcategoryGeneratedByIndecomposableProjectiveObjects( reps ) ) then
        return false;
      fi;
      return true;
    end,
    { projs, add_closure } -> DecompositionFunctorOfProjectiveQuiverRepresentations( AmbientCategory( projs ) ),
    "Decomposition of projective objects",
    "Decomposition of projective quiver representations: projs -> additive closure( indec_projs )"
  ]; 

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );


# from additive subcategory of projectives to additive closure of algebroid
functor :=
  [
    IsCapFullSubcategory,
    IsAdditiveClosureCategory,
    function( projs, add_closure )
      local reps, algebroid, A;
      
      reps := AmbientCategory( projs );
      
      if not IsQuiverRepresentationCategory( reps ) then
        return false;
      fi;
      
      algebroid := UnderlyingCategory( add_closure );
      
      if not IsAlgebroid( algebroid ) then
        return false;
      fi;
      if not HasFullSubcategoryGeneratedByProjectiveObjects( reps ) then
        return false;
      fi;
      if not IsIdenticalObj( projs, FullSubcategoryGeneratedByProjectiveObjects( reps ) ) then
        return false;
      fi;
      
      A := UnderlyingQuiverAlgebra( algebroid );
      
      if not HasOppositeAlgebra( A ) then
        return false;
      fi;
      
      if not IsIdenticalObj(
                OppositeAlgebra( A ),
                AlgebraOfCategory( reps )
              ) then
              
        return false;
        
      fi;
     
      return true;
      
    end,
    
    function( projs, add_closure )
      local pres, algebroid, I, J;
      
      pres := AmbientCategory( projs );
      
      algebroid := UnderlyingCategory( add_closure );
      
      I := DecompositionFunctorOfProjectiveQuiverRepresentations( pres );
      
      J := InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( algebroid );
      J := ExtendFunctorToAdditiveClosures( J );
      
      J := PreCompose( I, J );
      
      J!.Name := "Decomposition of projective objects";
      
      return J;
      
    end,
    "Decomposition of projective objects",
    "Decomposition of projective quiver representations: projs -> additive closure( algebroid )"
  ]; 

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

# from additive closure of algebroid to additive subcategory of projectives
functor :=
  [
    IsAdditiveClosureCategory,
    IsCapFullSubcategory,
    function( add_closure, projs )
      local reps, algebroid, A;
      
      reps := AmbientCategory( projs );
      
      if not IsQuiverRepresentationCategory( reps ) then
        return false;
      fi;
      algebroid := UnderlyingCategory( add_closure );
      if not IsAlgebroid( algebroid ) then
        return false;
      fi;
      if not HasFullSubcategoryGeneratedByProjectiveObjects( reps ) then
        return false;
      fi;
      if not IsIdenticalObj( projs, FullSubcategoryGeneratedByProjectiveObjects( reps ) ) then
        return false;
      fi;
      
      A := UnderlyingQuiverAlgebra( algebroid );
      
      if not HasOppositeAlgebra( A ) then
        return false;
      fi;
      
      if not IsIdenticalObj(
                OppositeAlgebra( A ),
                AlgebraOfCategory( reps )
              ) then
              
        return false;
        
      fi;
     
      return true;
      
    end,
    
    function( add_closure, projs )
      local pres, algebroid, J;
      
      pres := AmbientCategory( projs );
      
      algebroid := UnderlyingCategory( add_closure );
      
      J := YonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( algebroid );
      J := PreCompose( J, InclusionFunctor( RangeOfFunctor( J ) ) );
      
      J := RestrictFunctorToFullSubcategoryOfRange( J, projs );
      J := ExtendFunctorToAdditiveClosureOfSource( J );
      
      J!.Name := "Yoneda embedding";
      
      return J;
      
    end,
    "Yoneda embedding",
    "Yoneda embedding from additive closure of algebroid to category of projective quiver representations"
  ]; 

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

##
functor :=
  [
    IsQuiverRowsCategory,
    IsAdditiveClosureCategory,
    { c1, c2 } -> IsAlgebroid( UnderlyingCategory( c2 ) ) and
                    IsIdenticalObj(
                        UnderlyingQuiver( c1 ),
                        UnderlyingQuiver( UnderlyingCategory( c2 ) )
                      ),
    { c1, c2 } -> IsomorphismFromQuiverRowsIntoAdditiveClosureOfAlgebroid( c1, c2 ),
    "Isomorphism functor",
    "Isomorphism functor from quiver rows to additive closure of algebroid"
  ];

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

##
functor :=
  [
    IsAdditiveClosureCategory,
    IsQuiverRowsCategory,
    { c1, c2 } -> IsAlgebroid( UnderlyingCategory( c1 ) ) and
                    IsIdenticalObj(
                      UnderlyingQuiver( c2 ),
                      UnderlyingQuiver( UnderlyingCategory( c1 ) )
                    ),
    { c1, c2 } -> IsomorphismFromAdditiveClosureOfAlgebroidIntoQuiverRows( c1, c2 ),
    "Isomorphism functor",
    "Isomorphism functor from additive closure of algebroid to quiver rows"
  ];

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
if IsPackageLoaded( "homotopycategories" ) then
  ExtendFunctorMethodToHomotopyCategories( functor );
fi;


functor := 
PreComposeFunctorMethods(
  ALL_FUNCTORS_METHODS.( "Isomorphism functor from quiver rows to additive closure of algebroid" ),
  ALL_FUNCTORS_METHODS.( "Yoneda embedding from additive closure of algebroid to category of projective quiver representations" ),
  function( quiver_rows, projs )
    local A;
    
    if not IsQuiverRowsCategory( quiver_rows ) then
      return false;
    fi;
    if not ( IsCapFullSubcategory( projs ) and IsQuiverRepresentationCategory( AmbientCategory( projs ) ) ) then
      return false;
    fi;
    A := UnderlyingQuiverAlgebra( quiver_rows );
    if not HasOppositeAlgebra( A ) then
      return false;
    fi;
    if not IsIdenticalObj(
                OppositeAlgebra( A ),
                AlgebraOfCategory( AmbientCategory( projs ) )
              ) then
      return false;
    fi;
    return true;
  end,
  function( quiver_rows, projs )
    return AdditiveClosure( Algebroid( UnderlyingQuiverAlgebra( quiver_rows ) ) );
  end
);

ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

functor :=
  [
    IsAdditiveClosureCategory,
    IsCapFullSubcategory,
    function( add_closure, projs )
      local hom, algebroid, algebroid_op;
      
      hom := AmbientCategory( projs );
      
      if not IsFunctorCategory( hom ) then
        return false;
      fi;
      algebroid := UnderlyingCategory( add_closure );
      if not IsAlgebroid( algebroid ) then
        return false;
      fi;
      if not HasFullSubcategoryGeneratedByProjectiveObjects( hom ) then
        return false;
      fi;
      if not IsIdenticalObj( projs, FullSubcategoryGeneratedByProjectiveObjects( hom ) ) then
        return false;
      fi;
      
      if not HasOppositeAlgebroid( algebroid ) then
        return false;
      fi;
      
      algebroid_op := Source( hom );
      
      if not IsIdenticalObj( algebroid_op, OppositeAlgebroid( algebroid ) ) then
        return false;
      fi;
     
      return true;
      
    end,
    
    function( add_closure, projs )
      local hom, algebroid, J;
      
      hom := AmbientCategory( projs );
      
      algebroid := UnderlyingCategory( add_closure );
      
      J := YonedaIsomorphismOntoFullSubcategoryOfCategoryOfFunctors( algebroid );
      J := PreCompose( J, InclusionFunctor( RangeOfFunctor( J ) ) );
      
      J := RestrictFunctorToFullSubcategoryOfRange( J, projs );
      J := ExtendFunctorToAdditiveClosureOfSource( J );
      
      J!.Name := "Yoneda embedding";
      
      return J;
      
    end,
    "Yoneda embedding",
    "Yoneda embedding from additive closure of algebroid to category of projective objects in category of functors"
  ]; 

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );


functor :=
  PreComposeFunctorMethods(
    ALL_FUNCTORS_METHODS.("Isomorphism functor from quiver rows to additive closure of algebroid"),
    ALL_FUNCTORS_METHODS.("Yoneda embedding from additive closure of algebroid to category of projective objects in category of functors"),
    function( quiver_rows, projs )
      local functors, A;
      if not IsQuiverRowsCategory( quiver_rows ) then
        return false;
      fi;
      if not IsCapFullSubcategory( projs ) then
        return false;
      fi;
      functors := AmbientCategory( projs );
      if not IsFunctorCategory( functors ) then
        return false;
      fi;
      if not HasFullSubcategoryGeneratedByProjectiveObjects( functors ) then
        return false;
      fi;
      if not IsIdenticalObj( projs, FullSubcategoryGeneratedByProjectiveObjects( functors ) ) then
        return false;
      fi;
      A := UnderlyingQuiverAlgebra( quiver_rows );
      if not HasOppositeAlgebra( A ) then
        return false;
      fi;
      if not IsIdenticalObj(
                OppositeAlgebra( A ),
                UnderlyingQuiverAlgebra( Source( functors ) )
              ) then
        return false;
      fi;
      return true;
      
    end,
    { quiver_rows, projs } -> AdditiveClosure( OppositeAlgebroid( Source( AmbientCategory( projs ) ) ) )
);

ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );



#functor :=
#  [
#    IsCapFullSubcategory,
#    IsAdditiveClosureCategory,
#    function( projs, add_closure )
#      local hom, indec;
#      hom := AmbientCategory( projs );
#      if not IsFunctorCategory( hom ) then
#        return false;
#      fi;
#      indec := UnderlyingCategory( add_closure );
#      if not HasFullSubcategoryGeneratedByIndecomposableProjectiveObjects( hom ) then
#        return false;
#      fi;
#      if not IsIdenticalObj( indec, FullSubcategoryGeneratedByIndecomposableProjectiveObjects( hom ) ) then
#        return false;
#      fi;
#      return true;
#    end,
#    
#    function ( projs, add_closure )
#      local hom, iprojs, I, J, reps, projs_reps, iprojs_reps, U_1, U_2, U_3, U;
#      
#      hom := AmbientCategory( projs );
#      
#      iprojs := UnderlyingCategory( add_closure );
#      
#      I := IsomorphismOntoCategoryOfQuiverRepresentations( hom );
#      
#      J := IsomorphismFromCategoryOfQuiverRepresentations( hom );
#      
#      reps := RangeOfFunctor( I );
#      
#      projs_reps := FullSubcategoryGeneratedByProjectiveObjects( reps );
#      
#      iprojs_reps := FullSubcategoryGeneratedByIndecomposableProjectiveObjects( reps );
#      
#      U_1 := RestrictFunctorToFullSubcategories( I, projs, projs_reps );
#      
#      U_2 := DecompositionFunctorOfProjectiveQuiverRepresentations( reps );
#      
#      U_3 := ExtendFunctorToAdditiveClosures(
#                RestrictFunctorToFullSubcategories( J, iprojs_reps, iprojs )
#              );
#      
#      U := PreCompose( [ U_1, U_2, U_3 ] );
#      
#      U!.Name := "Decomposition functor of projective objects in terms of indecomposable projective objects";
#      
#      return U;
#      
#    end,
#    "Decomposition of projective objects",
#    "Decomposition functor: projective objects in category of functors -> additive closure ( indec_projs )"
#  ]; 
#
#AddFunctor( functor );
#ExtendFunctorMethodToComplexCategories( functor );
#ExtendFunctorMethodToHomotopyCategories( functor );

#functor :=
#  [
#    IsCapFullSubcategory,
#    IsAdditiveClosureCategory,
#    function( projs, add_closure )
#      local hom, algebroid;
#      
#      hom := AmbientCategory( projs );
#      
#      if not IsFunctorCategory( hom ) then
#        return false;
#      fi;
#      
#      algebroid := UnderlyingCategory( add_closure );
#      
#      if not IsAlgebroid( algebroid ) then
#        return false;
#      fi;
#      
#      if not HasOppositeAlgebroid( algebroid ) then
#        return false;
#      fi;
#      
#      if not IsIdenticalObj(
#                OppositeAlgebroid( algebroid ),
#                Source( hom )
#              ) then
#              
#        return false;
#        
#      fi;
#      
#      return true;
#      
#    end,
#    function ( projs, add_closure )
#      local hom, algebroid, I, reps, projs_reps, U_1, U_2, U_3, U;
#      
#      hom := AmbientCategory( projs );
#      
#      algebroid := UnderlyingCategory( add_closure );
#      
#      I := IsomorphismOntoCategoryOfQuiverRepresentations( hom );
#      
#      reps := RangeOfFunctor( I );
#      
#      projs_reps := FullSubcategoryGeneratedByProjectiveObjects( reps );
#      
#      U_1 := RestrictFunctorToFullSubcategories( I, projs, projs_reps );
#      
#      U_2 := DecompositionFunctorOfProjectiveQuiverRepresentations( reps );
#      
#      U_3 := ExtendFunctorToAdditiveClosures(
#                InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( algebroid )
#             );
#      
#      U := PreCompose( [ U_1, U_2, U_3 ] );
#      
#      U!.Name := "Decomposition of projective objects";
#      
#      return U;
#      
#    end,
#    "Decomposition of projective objects",
#    "Decomposition functor: projective objects in category of functors -> additive closure( algebroid )"
#  ]; 
#
#AddFunctor( functor );
#ExtendFunctorMethodToComplexCategories( functor );
#ExtendFunctorMethodToHomotopyCategories( functor );

# from additive subcategory of projective objects in category of functors to quiver rows
#
#functor := PreComposeFunctorMethods(
#  ALL_FUNCTORS_METHODS.( "Decomposition functor: projective objects in category of functors -> additive closure( algebroid )" ),
#  ALL_FUNCTORS_METHODS.( "Isomorphism functor from additive closure of algebroid to quiver rows" ),
#  function( projs, quiver_rows )
#    local A;
#    if not IsQuiverRowsCategory( quiver_rows ) then
#      return false;
#    fi;
#    if not ( IsCapFullSubcategory( projs ) and IsFunctorCategory( AmbientCategory( projs ) ) ) then
#      return false;
#    fi;
#    A := UnderlyingQuiverAlgebra( quiver_rows );
#    if not HasOppositeAlgebra( A ) then
#      return false;
#    fi;
#    if not IsIdenticalObj(
#                OppositeAlgebra( A ),
#                UnderlyingQuiverAlgebra( Source( AmbientCategory( projs ) ) )
#              ) then
#      return false;
#    fi;
#    
#    return true;
#    end,
#  
#  function( projs, quiver_rows )
#    return AdditiveClosure( OppositeAlgebroid( Source( AmbientCategory( projs ) ) ) );
#  end
#);  
#
#ExtendFunctorMethodToComplexCategories( functor );
#ExtendFunctorMethodToHomotopyCategories( functor );

# from additive subcategory of projective quiver representations to quiver rows
#
functor := PreComposeFunctorMethods(
  ALL_FUNCTORS_METHODS.( "Decomposition of projective quiver representations: projs -> additive closure( algebroid )" ),
  ALL_FUNCTORS_METHODS.( "Isomorphism functor from additive closure of algebroid to quiver rows" ),
  function( projs, quiver_rows )
    local A;
    
    if not IsQuiverRowsCategory( quiver_rows ) then
      return false;
    fi;
    if not ( IsCapFullSubcategory( projs ) and IsQuiverRepresentationCategory( AmbientCategory( projs ) ) ) then
      return false;
    fi;
    A := UnderlyingQuiverAlgebra( quiver_rows );
    if not HasOppositeAlgebra( A ) then
      return false;
    fi;
    if not IsIdenticalObj(
                OppositeAlgebra( A ),
                AlgebraOfCategory( AmbientCategory( projs ) )
              ) then
      return false;
    fi;
    return true;
  end,
  function( projs, quiver_rows )
    return AdditiveClosure( Algebroid( UnderlyingQuiverAlgebra( quiver_rows ) ) );
  end
);  

ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );


##
InstallMethod( QuasiInverseOfDecompositionFunctorOfProjectiveQuiverRepresentations,
          [ IsQuiverRepresentationCategory ],
  function( cat )
    local indec_projs, projs, I;
    
    indec_projs := FullSubcategoryGeneratedByIndecomposableProjectiveObjects( cat );
    
    projs := FullSubcategoryGeneratedByProjectiveObjects( cat );
    
    I := InclusionFunctor( indec_projs );
    
    I := RestrictFunctorToFullSubcategoryOfRange( I, projs );
    
    I := ExtendFunctorToAdditiveClosureOfSource( I );
    
    I!.Name := "Equivalence functor from additive closure onto additive full subcategory generated by projective objects";
    
    return I;
    
end );

functor :=
  [
    IsAdditiveClosureCategory,
    IsCapFullSubcategory,
    function( add_closure, projs )
      local reps, indec;
      reps := AmbientCategory( projs );
      if not IsQuiverRepresentationCategory( reps ) then
        return false;
      fi;
      indec := UnderlyingCategory( add_closure );
      if not HasFullSubcategoryGeneratedByIndecomposableProjectiveObjects( reps ) then
        return false;
      fi;
      if not IsIdenticalObj( indec, FullSubcategoryGeneratedByIndecomposableProjectiveObjects( reps ) ) then
        return false;
      fi;
      return true;
    end,
    { add_closure, projs } -> QuasiInverseOfDecompositionFunctorOfProjectiveQuiverRepresentations( AmbientCategory( projs ) ),
    "Isomorphism functor",
    "Isomorphism: additive closure of indec projective quiver representations -> projective quiver representations"
  ]; 

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

##
InstallMethod( DecompositionFunctorOfInjectiveQuiverRepresentations,
          [ IsQuiverRepresentationCategory ],
  function( cat )
    Error( "??" ); 
end );

functor :=
  [
    IsCapFullSubcategory,
    IsAdditiveClosureCategory,
    function( injs, add_closure )
      local reps, indec;
      reps := AmbientCategory( injs );
      if not IsQuiverRepresentationCategory( reps ) then
        return false;
      fi;
      indec := UnderlyingCategory( add_closure );
      if not HasFullSubcategoryGeneratedByIndecomposableInjectiveObjects( reps ) then
        return false;
      fi;
      if not IsIdenticalObj( indec, FullSubcategoryGeneratedByIndecomposableInjectiveObjects( reps ) ) then
        return false;
      fi;
      return true;
    end,
    { injs, add_closure } -> DecompositionFunctorOfInjectiveQuiverRepresentations( AmbientCategory( injs ) ),
    "Decomposition of injective objects",
    "Decomposition: injective quiver representations -> additive closure( indec injective quiver representations )"
  ]; 

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );


##
InstallMethod( QuasiInverseOfDecompositionFunctorOfInjectiveQuiverRepresentations,
          [ IsQuiverRepresentationCategory ],
  function( cat )
    local indec_injs, injs, I;
    
    indec_injs := FullSubcategoryGeneratedByIndecomposableInjectiveObjects( cat );
    
    injs := FullSubcategoryGeneratedByInjectiveObjects( cat );
    
    I := InclusionFunctor( indec_injs );
    
    I := RestrictFunctorToFullSubcategoryOfRange( I, injs );
    
    I := ExtendFunctorToAdditiveClosureOfSource( I );
    
    I!.Name := "Equivalence functor additive closure onto additive full subcategory generated by injective objects";
    
    return I;
    
end );

functor :=
  [
    IsAdditiveClosureCategory,
    IsCapFullSubcategory,
    function( add_closure, injs )
      local reps, indec;
      reps := AmbientCategory( injs );
      if not IsQuiverRepresentationCategory( reps ) then
        return false;
      fi;
      indec := UnderlyingCategory( add_closure );
      if not HasFullSubcategoryGeneratedByIndecomposableInjectiveObjects( reps ) then
        return false;
      fi;
      if not IsIdenticalObj( indec, FullSubcategoryGeneratedByIndecomposableInjectiveObjects( reps ) ) then
        return false;
      fi;
      return true;
    end,
    { add_closure, injs } -> QuasiInverseOfDecompositionFunctorOfInjectiveQuiverRepresentations( AmbientCategory( injs ) ),
    "Isomorphism functor",
    "Isomorphism: additive closure of indec injective quiver representations -> injective quiver representations"
  ]; 

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

###
#InstallMethod( YonedaIsomorphismOntoFullSubcategoryOfCategoryOfFunctors,
#          [ IsAlgebroid ],
#  function( algebroid )
#    local algebroid_op, k, functors, full, Y, name, F;
#    
#    algebroid_op := OppositeAlgebroid( algebroid );
#    
#    SetAlgebroid( UnderlyingQuiverAlgebra( algebroid_op ), algebroid_op );
#
#    k := CommutativeRingOfLinearCategory( algebroid_op );
#    
#    functors := Hom( algebroid_op, MatrixCategory( k ) );
#    
#    full := FullSubcategoryGeneratedByIndecomposableProjectiveObjects( functors );
#    
#    Y := YonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( algebroid );
#    
#    name := "Isomorphism functor from algebroid onto full subcategory generated by indecomposable projective objects";
#    
#    F := CapFunctor( name, algebroid, full );
#    
#    AddObjectFunction( F,
#      function( a )
#      
#        return AsSubcategoryCell( full, ConvertToCellInFunctorCategory( UnderlyingCell( Y( a ) ), functors ) );
#        
#      end );
#      
#    AddMorphismFunction( F,
#      function( s, alpha, r )
#      
#        return AsSubcategoryCell( s, ConvertToCellInFunctorCategory( UnderlyingCell(s), UnderlyingCell( Y( alpha ) ), UnderlyingCell( r ) ), r );
#        
#      end );
#    
#    return F;
#     
#end );

##
functor :=
  [ 
    IsAlgebroid,
    IsCapFullSubcategory,
    function( algebroid, full )
      local hom;
      
      hom := AmbientCategory( full );
      
      if not IsFunctorCategory( hom ) then
        return false;
      fi;
      
      if not HasFullSubcategoryGeneratedByIndecomposableProjectiveObjects( hom ) then
        return false;
      fi;
      
      if not IsIdenticalObj( FullSubcategoryGeneratedByIndecomposableProjectiveObjects( hom ), full ) then
        return false;
      fi;
      
      if  not HasOppositeAlgebroid( algebroid ) then
        return false;
      fi;
      
      if not IsIdenticalObj(
                OppositeAlgebroid( algebroid ),
                Source( hom ) 
              ) then
              
        return false;
        
      fi;
      
      return true;
      
    end,
    { algebroid, full } -> YonedaIsomorphismOntoFullSubcategoryOfCategoryOfFunctors( algebroid ),
    "Yoneda isomorphism",
    "Yoneda isomorphism from algebroid to indec projective objects in category of functors"
  ];

AddFunctor( functor );
functor := ExtendFunctorMethodToAdditiveClosures( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

##
InstallMethod( YonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations,
          [ IsAlgebroid ],
  function( algebroid )
    Error( "??" ); 
end );

##
functor :=
  [ 
    IsAlgebroid,
    IsCapFullSubcategory,
    function( algebroid, full )
      local reps, A;
      
      reps := AmbientCategory( full );
      
      if not IsQuiverRepresentationCategory( reps ) then
        return false;
      fi;
      
      if not HasFullSubcategoryGeneratedByIndecomposableProjectiveObjects( reps ) then
        return false;
      fi;
      
      if not IsIdenticalObj( FullSubcategoryGeneratedByIndecomposableProjectiveObjects( reps ), full ) then
        return false;
      fi;
      
      A := UnderlyingQuiverAlgebra( algebroid );
      
      if not HasOppositeAlgebra( A ) then
        return false;
      fi;
      
      if not IsIdenticalObj(
                OppositeAlgebra( A ),
                AlgebraOfCategory( reps )
              ) then
              
        return false;
        
      fi;
      
      return true;
      
    end,
    { algebroid, full } -> YonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( algebroid ),
    "Yoneda isomorphism",
    "Yoneda isomorphism from algebroid to indec projective quiver representations"
  ];

AddFunctor( functor );
functor := ExtendFunctorMethodToAdditiveClosures( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );    

##
InstallOtherMethod( YonedaIsomorphismOntoFullSubcategoryOfCategoryOfFunctors,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local full, iso_1, algebroid, iso_2, iso, ind_projs, r, name, cell_func;
    
    full := FullSubcategory( collection );
    
    iso_1 := IsomorphismOntoAlgebroid( collection );
    
    algebroid := RangeOfFunctor( iso_1 );
    
    iso_2 := YonedaIsomorphismOntoFullSubcategoryOfCategoryOfFunctors( algebroid );
    
    iso := PreCompose( iso_1, iso_2 );
    
    ind_projs := RangeOfFunctor( iso );
    
    name := "Isomorphism: strong exceptional collection -> indecomposable projective objects";
    
    cell_func := c -> ApplyFunctor( iso, c );
    
    return CreateAdditiveFunctorByTwoFunctions( name, full, ind_projs, cell_func, cell_func );
end );


##
InstallMethod( YonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local full, iso_1, algebroid, iso_2, iso, ind_projs, r, name, cell_func;
    
    full := FullSubcategory( collection );
    
    iso_1 := IsomorphismOntoAlgebroid( collection );
    
    algebroid := RangeOfFunctor( iso_1 );
    
    iso_2 := YonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( algebroid );
    
    iso := PreCompose( iso_1, iso_2 );
    
    ind_projs := RangeOfFunctor( iso );
    
    name := "Isomorphism functor from exceptional collection in full subcategory generated by indecomposable projective objects";
    
    cell_func := c -> ApplyFunctor( iso, c );
    
    return CreateAdditiveFunctorByTwoFunctions( name, full, ind_projs, cell_func, cell_func );
end );

##
InstallMethod( InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local full, iso_1, algebroid, iso_2, iso, ind_projs, r, name, cell_func;
    
    full := FullSubcategory( collection );
    
    iso_1 := IsomorphismFromAlgebroid( collection );
    
    algebroid := SourceOfFunctor( iso_1 );
    
    iso_2 := InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( algebroid );
    
    iso := PostCompose( iso_1, iso_2 );
    
    ind_projs := SourceOfFunctor( iso );
    
    name := "Isomorphism functor from full subcategory generated by indecomposable projective objects onto exceptional collection";
    
    cell_func := c -> ApplyFunctor( iso, c );
    
    return CreateAdditiveFunctorByTwoFunctions( name, ind_projs, full, cell_func, cell_func );
    
end );

###
#InstallMethod( InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfFunctors,
#          [ IsAlgebroid ],
#          
#  function( algebroid )
#    local algebroid_op, k, functors, full, Y, name, F;
#    
#    algebroid_op := OppositeAlgebroid( algebroid );
#    
#    SetAlgebroid( UnderlyingQuiverAlgebra( algebroid_op ), algebroid_op );
#
#    k := CommutativeRingOfLinearCategory( algebroid_op );
#    
#    functors := Hom( algebroid_op, MatrixCategory( k ) );
#    
#    full := FullSubcategoryGeneratedByIndecomposableProjectiveObjects( functors );
#    
#    Y := InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( algebroid );
#    
#    name := "Isomorphism functor from full subcategory generated by indecomposable projective objects onto algebroid";
#    
#    F := CapFunctor( name, full, algebroid );
#    
#    AddObjectFunction( F,
#      function( a )
#        
#        return Y( ConvertToCellInCategoryOfQuiverRepresentations( UnderlyingCell( a ) ) / SourceOfFunctor( Y ) );
#        
#    end );
#    
#    AddMorphismFunction( F,
#      function( s, alpha, r )
#        
#        return Y( ConvertToCellInCategoryOfQuiverRepresentations( UnderlyingCell( alpha ) ) / SourceOfFunctor( Y ) );
#        
#    end );
#    
#    return F;
#    
#end );

##
functor :=
  [ 
    IsCapFullSubcategory,
    IsAlgebroid,
    function( full, algebroid )
      local hom;
      
      hom := AmbientCategory( full );
      
      if not IsFunctorCategory( hom ) then
        return false;
      fi;
      
      if not HasFullSubcategoryGeneratedByIndecomposableProjectiveObjects( hom ) then
        return false;
      fi;
      
      if not IsIdenticalObj( FullSubcategoryGeneratedByIndecomposableProjectiveObjects( hom ), full ) then
        return false;
      fi;
      
      if  not HasOppositeAlgebroid( algebroid ) then
        return false;
      fi;
      
      if not IsIdenticalObj(
                OppositeAlgebroid( algebroid ),
                Source( hom ) 
              ) then
              
        return false;
        
      fi;
      
      return true;
      
    end,
    { full, algebroid } -> InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfFunctors( algebroid ),
    "Inverse of Yoneda isomorphism",
    "Inverse of Yoneda isomorphism: indec projective objects in category of functors to algebroid"
  ];

AddFunctor( functor );
functor := ExtendFunctorMethodToAdditiveClosures( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

##
InstallMethod( InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations,
          [ IsAlgebroid ],
          
  function( algebroid )
    Error( "??" );
end );

##
functor :=
  [ 
    IsCapFullSubcategory,
    IsAlgebroid,
    function( full, algebroid )
      local reps, A;
      
      reps := AmbientCategory( full );
      
      if not IsQuiverRepresentationCategory( reps ) then
        return false;
      fi;
      
      if not HasFullSubcategoryGeneratedByIndecomposableProjectiveObjects( reps ) then
        return false;
      fi;
      
      if not IsIdenticalObj( FullSubcategoryGeneratedByIndecomposableProjectiveObjects( reps ), full ) then
        return false;
      fi;
      
      A := UnderlyingQuiverAlgebra( algebroid );
      
      if not HasOppositeAlgebra( A ) then
        return false;
      fi;
      
      if not IsIdenticalObj(
                OppositeAlgebra( A ),
                AlgebraOfCategory( reps )
              ) then
              
        return false;
        
      fi;
      
      return true;
      
    end,
    { full, algebroid } -> InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( algebroid ),
    "Inverse of Yoneda isomorphism",
    "Inverse of Yoneda isomorphism: indec projective quiver representations -> algebroid"
  ];

AddFunctor( functor );
functor := ExtendFunctorMethodToAdditiveClosures( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

##
InstallMethod( IsomorphismOntoAlgebroid,
        [ IsStrongExceptionalCollection ],
  function( collection )
    local n, full, A, algebroid, r, name, object_func, morphism_func, conv, algebroid_ring;
    
    n := NumberOfObjects( collection );
    
    full := FullSubcategory( collection );
    
    A := EndomorphismAlgebra( collection );
    
    algebroid := Algebroid( A );
    
    algebroid_ring := CommutativeRingOfLinearCategory( algebroid );
    
    if not IsIdenticalObj( CommutativeRingOfLinearCategory( full ), algebroid_ring ) then
      
      conv := a -> a / algebroid_ring;
      
    else
      
      conv := IdFunc;
      
    fi;
    
    name := "Abstraction isomorphism";
    
    object_func :=
      function( e )
        local p;
        
        p := PositionProperty( [ 1 .. n ], i -> IsEqualForObjects( e, collection[ i ] ) );
        
        return SetOfObjects( algebroid )[ p ];
        
    end;
    
    morphism_func :=
      function( phi )
        local s, source, i, r, range, j, basis, labels, dim, paths, rel, v;
        
        s := Source( phi );
        
        source := object_func( s );
        
        i := PositionProperty( [ 1 .. n ], k -> IsEqualForObjects( s, collection[ k ] ) );
        
        r := Range( phi );
        
        range := object_func( r );
        
        j := PositionProperty( [ 1 .. n ], k -> IsEqualForObjects( r, collection[ k ] ) );
        
        basis := BasisOfPaths( collection, i, j );
        
        v := collection!.char;
        
        if IsEmpty( basis ) then
          
          return ZeroMorphism( source, range );
          
        fi;
        
        labels := LabelsForBasisOfPaths( collection, [ i, j ] );
        
        dim := Length( basis );
        
        if i > j then
          
          return ZeroMorphism( source, range );
          
        elif i = j then
          
          paths := [ IdentityMorphism( algebroid.( i ) ) ]; # Because the quiver has no loops.
          
        else
          
          paths :=
            List( labels, label ->
              PreCompose(
                List( label, arrow_label ->
                  algebroid.(
                    Concatenation(
                       v,
                       String( arrow_label[ 1 ] ),
                       "_",
                       String( arrow_label[ 2 ] ),
                       "_",
                       String( arrow_label[ 3 ] ) )
                            )
                )
              )
            );
        fi;
        
        rel := RelationsBetweenMorphisms( Concatenation( [ phi ], basis ) );
        
        if Length( rel ) > 1 then
          
          Error( "This should not happen, please report this" );
          
        fi;
        
        rel := AdditiveInverse( Inverse( rel[ 1 ][ 1 ] ) ) * rel[ 1 ];
        
        return List( rel{ [ 2 .. dim + 1 ] }, conv ) * paths;
        
    end;
    
    return CreateAdditiveFunctorByTwoFunctions( name, full, algebroid, object_func, morphism_func );
    
end );

##
functor :=
  [
    IsCapFullSubcategory,
    IsAlgebroid,
    function( full, oid )
      local collection;
      if not HasStrongExceptionalCollection( full ) then
        return false;
      fi;
      collection := StrongExceptionalCollection( full );
      if not HasAlgebroid( collection ) then
        return false;
      fi;
      if not IsIdenticalObj( oid, Algebroid( collection ) ) then
        return false;
      fi;
      return true;
    end,
    { full, oid } -> IsomorphismOntoAlgebroid( StrongExceptionalCollection( full ) ),
    "Abstraction isomorphism",
    "Isomorphism: strong exceptional collection -> algebroid"
  ];

AddFunctor( functor );
functor := ExtendFunctorMethodToAdditiveClosures( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

##
InstallMethod( IsomorphismFromAlgebroid,
        [ IsStrongExceptionalCollection ],
  function( collection )
    local n, full, A, algebroid, r, name, object_func, morphism_func;
    
    n := NumberOfObjects( collection );
    
    full := FullSubcategory( collection );
    
    A := EndomorphismAlgebra( collection );
    
    algebroid := Algebroid( A );
    
    name := "Realization isomorphism";
    
    object_func :=
      function( e )
        local p;
        
        p := VertexIndex( UnderlyingVertex( e ) );
        
        return collection[ p ];
        
    end;
    
    morphism_func :=
      function( phi )
        local source, range, s, i, r, j, e, paths, coeffs, arrow_list, paths_list;
        
        source := object_func( Source( phi ) );
        
        range := object_func( Range( phi ) );
        
        s := Source( phi );
        
        i := VertexIndex( UnderlyingVertex( s ) );
        
        r := Range( phi );
        
        j := VertexIndex( UnderlyingVertex( r ) );
        
        e := Representative( UnderlyingQuiverAlgebraElement( phi ) );
        
        if IsZero( e ) then
          
          return ZeroMorphism( source, range );
          
        fi;
        
        paths := Paths( e );
        
        coeffs := Coefficients( e );
        
        if Length( paths ) = 1 and Source( paths[ 1 ] ) = Target( paths[ 1 ] ) then
          
          return coeffs * [ IdentityMorphism( source ) ];
          
        fi;
        
        arrow_list := List( paths, ArrowList );
        
        arrow_list := List( arrow_list,
          l -> List( l, arrow -> [
                                    VertexIndex( Source( arrow ) ),
                                    VertexIndex( Target( arrow ) ),
                                    Int( SplitString( Label( arrow ), "_" )[ 3 ] )
                                 ]
                    ) );
                    
        paths_list := List( arrow_list,
          l -> PreCompose(
                   List( l, indices -> Arrows( collection, indices[ 1 ], indices[ 2 ] )[ indices[ 3 ] ] )
                    ) );
                    
        return coeffs * paths_list;
        
    end;
    
    return CreateAdditiveFunctorByTwoFunctions( name, algebroid, full, object_func, morphism_func );
    
end );

##
functor :=
  [
    IsAlgebroid,
    IsCapFullSubcategory,
    function( oid, full )
      local collection;
      if not HasStrongExceptionalCollection( full ) then
        return false;
      fi;
      collection := StrongExceptionalCollection( full );
      if not HasAlgebroid( collection ) then
        return false;
      fi;
      if not IsIdenticalObj( oid, Algebroid( collection ) ) then
        return false;
      fi;
      return true;
    end,
    { oid, full } -> IsomorphismFromAlgebroid( StrongExceptionalCollection( full ) ),
    "Relatization isomorphism",
    "Isomorphism: algebroid -> strong exceptional collection"
  ];

AddFunctor( functor );
functor := ExtendFunctorMethodToAdditiveClosures( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

##
InstallMethod( LocalizationFunctor,
              [ IsHomotopyCategory ],
  function( homotopy )
    local complexes, cat, D, r, name, F;
    
    complexes := UnderlyingCategory( homotopy );
    
    cat := UnderlyingCategory( complexes );
    
    if IsChainComplexCategory( complexes ) then
      
      D := DerivedCategory( cat, false );
      
    else
      
      D := DerivedCategory( cat, true );
      
    fi;
    
    name := "Localization functor in derived category";
    
    F := CapFunctor( name, homotopy, D );
    
    AddObjectFunction( F, a -> a / D );
    
    AddMorphismFunction( F, { s, alpha, r } -> alpha / D );
    
    return F;
    
end );

functor :=
  [
    IsHomotopyCategory,
    IsDerivedCategory,
    { homotopy_cat, derived_cat } -> 
      IsIdenticalObj( homotopy_cat, UnderlyingCategory( derived_cat ) ),
    { homotopy_cat, derived_cat } -> LocalizationFunctor( homotopy_cat ),
    "The natural localization functor",
    "The natural localization functor from homotopy category onto derived category"
  ];
  
AddFunctor( functor );


functor :=
  [
    IsCapFullSubcategory,
    IsCapCategory,
    { full, category } -> 
      HasIsAdditiveCategory( full ) and IsAdditiveCategory( full ) and 
        IsIdenticalObj( AmbientCategory( full ), category ),
    function( full, category )
      local inc;
      
      inc := InclusionFunctor( full );
      inc!.Name := "The inclusion functor";
      
      return inc;
    end,
    "The inclusion functor",
    "The inclusion functor from full subcategory into its ambient category"
  ];
  
AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
ExtendFunctorMethodToHomotopyCategories( functor );

PreComposeFunctorMethods(
  ALL_FUNCTORS_METHODS.("ExtendFunctorToHomotopyCategoriesByCochains:The inclusion functor from full subcategory into its ambient category"),
  ALL_FUNCTORS_METHODS.("The natural localization functor from homotopy category onto derived category"),
  function( homotopy_projs, derived_cat )
    local projs, cat;
    
    projs := DefiningCategory( homotopy_projs );
    cat := DefiningCategory( derived_cat );
    if not IsCapFullSubcategory( projs ) then
      return false;
    fi;
    if not IsIdenticalObj( AmbientCategory( projs ), cat ) then
      return false;
    fi;
    if not HasFullSubcategoryGeneratedByProjectiveObjects( cat ) and
        IsIdenticalObj( projs, FullSubcategoryGeneratedByProjectiveObjects( cat ) ) then
        return false;
    fi;
    return true;
  end,
  { homotopy_projs, derived_cat } -> UnderlyingCategory( derived_cat )
);

##
InstallMethod( UniversalFunctorFromDerivedCategory,
          [ IsCapFunctor ],
  function( F )
    local homotopy_cat, C, cat, D, r, name, U;
    
    homotopy_cat := SourceOfFunctor( F );
    
    C := RangeOfFunctor( F );
    
    if not IsHomotopyCategory( homotopy_cat ) then
      
      Error( "The input be a functor from homotopy category of some abelian category" );
      
    fi;
    
    cat := DefiningCategory( homotopy_cat );
    
    if IsCochainComplexCategory( UnderlyingCategory( homotopy_cat ) ) then
      D := DerivedCategory( cat, true );  
    else
      D := DerivedCategory( cat, false );
    fi;
    
    name := "Universal functor from derived category onto a localization category";
    
    U := CapFunctor( name, D, C );
    
    AddObjectFunction( U,
      function( a )
        
        return ApplyFunctor( F, UnderlyingCell( a ) );
        
    end );
    
    AddMorphismFunction( U,
      function( s, alpha, r )
        local i, j;
        
        i := ApplyFunctor( F, SourceMorphism( UnderlyingRoof( alpha ) ) );
        
        j := ApplyFunctor( F, RangeMorphism( UnderlyingRoof( alpha ) ) );
        
        return PreCompose( Inverse( i ), j );
        
    end );
    
    return U;
    
end );

functor :=
  [
    IsDerivedCategory,
    IsHomotopyCategory,
    function( derived_cat, homotopy_cat )
      local full, cat;
      
      full := DefiningCategory( homotopy_cat );
      cat := DefiningCategory( derived_cat );
      if not IsCapFullSubcategory( full ) then
        return false;
      fi;
      if not IsIdenticalObj( cat, AmbientCategory( full ) ) then
        return false;
      fi;
      if not HasFullSubcategoryGeneratedByProjectiveObjects( cat ) then
          return false;
      fi;
      if not IsIdenticalObj( full, FullSubcategoryGeneratedByProjectiveObjects( cat ) ) then
        return false;
      fi;
      return true;
    end,
    { derived_cat, homotopy_cat } -> 
      UniversalFunctorFromDerivedCategory( LocalizationFunctorByProjectiveObjects( UnderlyingCategory( derived_cat ) ) ),
    "Universal functor from derived category",
    "Universal functor from derived category onto homotopy category of projectives"
  ];
  
AddFunctor( functor );

functor :=
  [
    IsDerivedCategory,
    IsHomotopyCategory,
    function( derived_cat, homotopy_cat )
      local full, cat;
      
      full := DefiningCategory( homotopy_cat );
      cat := DefiningCategory( derived_cat );
      if not IsCapFullSubcategory( full ) then
        return false;
      fi;
      if not IsIdenticalObj( cat, AmbientCategory( full ) ) then
        return false;
      fi;
      if not HasFullSubcategoryGeneratedByInjectiveObjects( cat ) then
          return false;
      fi;
      if not IsIdenticalObj( full, FullSubcategoryGeneratedByInjectiveObjects( cat ) ) then
        return false;
      fi;
      return true;
    end,
    { derived_cat, homotopy_cat } -> 
      UniversalFunctorFromDerivedCategory( LocalizationFunctorByInjectiveObjects( homotopy_cat ) ),
    "Universal functor from derived category",
    "Universal functor from derived category onto homotopy category of injectives"
  ];
  
AddFunctor( functor );

##
InstallMethod( LeftDerivedFunctor,
          [ IsCapFunctor, IsBool ],
          
  function( F, over_cochains )
    local H_1, cat_1, D_1, H_2, cat_2, D_2, name, LF, r;
    
    H_1 := SourceOfFunctor( F );
    
    H_2 := RangeOfFunctor( F );
    
    if not ( IsHomotopyCategory( H_1 ) and IsHomotopyCategory( H_2 ) ) then
      
      TryNextMethod( );
      
    fi;
    
    cat_1 := DefiningCategory( H_1 );
    
    D_1 := DerivedCategory( cat_1, over_cochains );
    
    cat_2 := DefiningCategory( H_2 );
    
    D_2 := DerivedCategory( cat_2, over_cochains );
    
    if not IsAbelianCategoryWithComputableEnoughProjectives( cat_1 ) then
      
      Error( Name( cat_1 ), " should be abelian with enough projectives!\n" );
      
    fi;
    
    name := "Left derived functor";
    
    LF := CapFunctor( name, D_1, D_2 );
    
    AddObjectFunction( LF,
      function( a )
        local p;
        
        p := ProjectiveResolution( UnderlyingCell( UnderlyingCell( a ) ), true ) / H_1;
        
        return ApplyFunctor( F, p ) / D_2;
        
    end );
    
    AddMorphismFunction( LF,
      function( s, alpha, r )
        local roof, quasi_iso, morphism, F_quasi_iso, F_morphism;
        
        roof := UnderlyingRoof( alpha );
        
        quasi_iso := SourceMorphism( roof );
        
        quasi_iso := MorphismBetweenProjectiveResolutions( UnderlyingCell( quasi_iso ), true ) / H_1;
        
        morphism := RangeMorphism( roof );
        
        morphism := MorphismBetweenProjectiveResolutions( UnderlyingCell( morphism ), true ) / H_1;
        
        F_quasi_iso := ApplyFunctor( F, quasi_iso );
        
        F_morphism := ApplyFunctor( F, morphism );
        
        roof := Roof( F_quasi_iso, F_morphism );
        
        return DerivedCategoryMorphism( s, roof, r );
        
    end );
    
    return LF;
    
end );

##
InstallMethod( LeftDerivedFunctor,
          [ IsCapFunctor, IsBool ],
  function( F, over_cochains )
    local cat_1;
    
    cat_1 := SourceOfFunctor( F );
    
    if not ( HasIsAbelianCategory( cat_1 )
                and IsAbelianCategory( cat_1 )
                  and IsAbelianCategoryWithComputableEnoughProjectives( cat_1 ) ) then
                  
      TryNextMethod( );
      
    fi;
    
    return LeftDerivedFunctor( ExtendFunctorToHomotopyCategories( F, over_cochains ), over_cochains );
    
end );

##
InstallMethod( RightDerivedFunctor,
          [ IsCapFunctor, IsBool ],
  function( F, over_cochains )
    local H_1, cat_1, D_1, H_2, cat_2, D_2, name, RF, r;
    
    H_1 := SourceOfFunctor( F );
    
    H_2 := RangeOfFunctor( F );
    
    if not ( IsHomotopyCategory( H_1 ) and IsHomotopyCategory( H_2 ) ) then
      
      TryNextMethod( );
      
    fi;
    
    cat_1 := DefiningCategory( H_1 );
    
    D_1 := DerivedCategory( cat_1, over_cochains );
    
    cat_2 := DefiningCategory( H_2 );
    
    D_2 := DerivedCategory( cat_2, over_cochains );
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( cat_1 ) then
      
      Error( Name( cat_1 ), " should be abelian with enough injectives!\n" );
      
    fi;
    
    name := "Right derived functor";
    
    RF := CapFunctor( name, D_1, D_2 );
    
    AddObjectFunction( RF,
      function( a )
        local i;
        
        i := InjectiveResolution( UnderlyingCell( UnderlyingCell( a ) ), true ) / H_1;
        
        return ApplyFunctor( F, i ) / D_2;
        
    end );
    
    AddMorphismFunction( RF,
      function( s, alpha, r )
        local roof, quasi_iso, morphism, F_quasi_iso, F_morphism;
        
        roof := UnderlyingRoof( alpha );
        
        quasi_iso := SourceMorphism( roof );
        
        quasi_iso := MorphismBetweenInjectiveResolutions( UnderlyingCell( quasi_iso ), true ) / H_1;
        
        morphism := RangeMorphism( roof );
        
        morphism := MorphismBetweenInjectiveResolutions( UnderlyingCell( morphism ), true ) / H_1;
        
        F_quasi_iso := ApplyFunctor( F, quasi_iso );
        
        F_morphism := ApplyFunctor( F, morphism );
        
        roof := Roof( F_quasi_iso, F_morphism );
        
        return DerivedCategoryMorphism( s, roof, r );
        
    end );
    
    return RF;
    
end );

##
InstallMethod( RightDerivedFunctor,
          [ IsCapFunctor, IsBool ],
  function( F, over_cochains )
    local cat_1;
    
    cat_1 := SourceOfFunctor( F );
    
    if not ( HasIsAbelianCategory( cat_1 )
                and IsAbelianCategory( cat_1 )
                  and IsAbelianCategoryWithComputableEnoughInjectives( cat_1 ) ) then
                  
      TryNextMethod( );
      
    fi;
    
    return RightDerivedFunctor( ExtendFunctorToHomotopyCategories( F, over_cochains ), over_cochains );
    
end );


########################################
#
# Convolution functor
#
########################################

##
InstallMethod( EquivalenceFromAdditiveClosure,
          [ IsCapFullSubcategory ],
  function( full )
    local I, add_closure_full;
    
    I := InclusionFunctor( full );
    
    I := ExtendFunctorToAdditiveClosureOfSource( I );
    
    add_closure_full := AdditiveClosureAsFullSubcategory( full );
    
    I := RestrictFunctorToFullSubcategoryOfRange( I, add_closure_full );
    
    I!.Name := "Isomorphism functor from formal additive closure onto additive colsure as full subcategory";
    
    return I;
    
end );

##
InstallMethod( EquivalenceFromAdditiveClosure,
          [ IsStrongExceptionalCollection ],
  collection -> EquivalenceFromAdditiveClosure( FullSubcategory( collection ) )
);

##
InstallMethod( EquivalenceFromHomotopyCategory,
          [ IsStrongExceptionalCollection ],
  collection -> ExtendFunctorToHomotopyCategories( EquivalenceFromAdditiveClosure( collection ) )
);

##
InstallMethod( EmbeddingFunctorFromAdditiveClosure,
          [ IsCapFullSubcategory ],
  function( full )
    local I, add_closure_full;
    
    I := InclusionFunctor( full );
    
    I := ExtendFunctorToAdditiveClosureOfSource( I );
    
    I!.Name := "Embedding functor from formal additive closure into the ambient category";
    
    return I;
    
end );

##
InstallMethod( EmbeddingFunctorFromAdditiveClosure,
          [ IsStrongExceptionalCollection ],
  collection -> EmbeddingFunctorFromAdditiveClosure( FullSubcategory( collection ) )
);

##
InstallMethod( EmbeddingFunctorFromHomotopyCategory,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local iota, ambient_cat, complexes_cat;
    
    iota := EmbeddingFunctorFromAdditiveClosure( collection );
    
    ambient_cat := AmbientCategory( collection );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if IsCochainComplexCategory( complexes_cat ) then
      
      return ExtendFunctorToHomotopyCategories( iota, true );
      
    elif IsChainComplexCategory( complexes_cat ) then
      
      return ExtendFunctorToHomotopyCategories( iota, false );
      
    else
      
      Error( "The ambient category of the collection should be a homotopy category!\n" );
      
    fi;
    
end );

##
BindGlobal( "SET_COMMUTATIVITY_NAT_ISO_BETWEEN_REPLACEMENT_AND_SHIFT",
  function( collection, rep )
    local D, sigma_D, C, sigma_C, rep_o_sigma_C, sigma_D_o_rep, name, eta;
    
    D := HomotopyCategory( collection );
    
    sigma_D := ShiftFunctor( D );
    
    C := AmbientCategory( collection );
    
    sigma_C := ShiftFunctor( C );
    
    rep_o_sigma_C := PostCompose( rep, sigma_C );
    
    sigma_D_o_rep := PostCompose( sigma_D, rep );
    
    name := "Natural isomorphism G o Σ => Σ o G";
    
    eta := NaturalTransformation( name, rep_o_sigma_C, sigma_D_o_rep );
    
    AddNaturalTransformationFunction( eta,
      function( rep_o_sigma_a, a, sigma_D_o_rep_a )
        local z_func;
        
        z_func := AsZFunction( i -> ( -1 ) ^ ( i - 1 ) * IdentityMorphism( rep_o_sigma_a[ i ] ) );
        
        return HomotopyCategoryMorphism( rep_o_sigma_a, sigma_D_o_rep_a, z_func );
        
    end );
    
    SetCommutativityNaturalTransformationWithShiftFunctor( rep, eta );
   
end );

##
InstallMethod( ReplacementFunctor,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, homotopy_cat, name, Rep;
    
    ambient_cat := AmbientCategory( collection );
    
    homotopy_cat := HomotopyCategory( collection );
    
    name := "Replacement functor";
    
    Rep := CapFunctor( name, ambient_cat, homotopy_cat );
    
    AddObjectFunction( Rep,
      a -> ExceptionalReplacement( a, collection, true )
    );
    
    AddMorphismFunction( Rep,
      { s, alpha, r } -> ExceptionalReplacement( alpha, collection, true )
    );
    
    SET_COMMUTATIVITY_NAT_ISO_BETWEEN_REPLACEMENT_AND_SHIFT( collection, Rep );
    
    return Rep;
    
end );

##
InstallMethod( ReplacementFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, complexes_cat, J, eta_J, G, eta_G, GJ, sigma_S, sigma_T, GJ_o_sigma_S, sigma_T_o_GJ, eta;
    
    ambient_cat := AmbientCategory( collection );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    J := IsomorphismOntoAlgebroid( collection );
    
    J := ExtendFunctorToAdditiveClosureOfSource( J );
    
    if IsChainComplexCategory( complexes_cat ) then
      
      J := ExtendFunctorToHomotopyCategories( J, false );
      
    else
      
      J := ExtendFunctorToHomotopyCategories( J, true );
      
    fi;
    
    eta_J := CommutativityNaturalTransformationWithShiftFunctor( J );
    
    G := ReplacementFunctor( collection );
    
    eta_G := CommutativityNaturalTransformationWithShiftFunctor( G );
    
    GJ := PreCompose( G, J );
    
    sigma_S := ShiftFunctor( SourceOfFunctor( GJ ) );
    
    sigma_T := ShiftFunctor( RangeOfFunctor( GJ ) );
    
    GJ_o_sigma_S := PostCompose( GJ, sigma_S );
    
    sigma_T_o_GJ := PostCompose( sigma_T, GJ );
    
    eta := NaturalTransformation( "Natural isomorphism G o Σ => Σ o G", GJ_o_sigma_S, sigma_T_o_GJ );
    
    AddNaturalTransformationFunction( eta,
      function( GJ_o_sigma_S_a, a, sigma_T_o_GJ_a )
        
        return PreCompose(
                  ApplyFunctor( J, ApplyNaturalTransformation( eta_G, a ) ),
                  ApplyNaturalTransformation( eta_J, ApplyFunctor( G, a ) )
                );
                
    end );
    
    SetCommutativityNaturalTransformationWithShiftFunctor( GJ, eta );
    
    GJ!.Name := "Replacement functor";
    
    return GJ;
    
end );

##
InstallMethod( ReplacementFunctorIntoHomotopyCategoryOfQuiverRows,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, complexes_cat, C, J, eta_J, G, eta_G, GJ, sigma_S, sigma_T, GJ_o_sigma_S, sigma_T_o_GJ, eta;
    
    ambient_cat := AmbientCategory( collection );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    C := Algebroid( collection );
    
    C := AdditiveClosure( C );
    
    J := IsomorphismOntoQuiverRows( C );
    
    if IsChainComplexCategory( complexes_cat ) then
      
      J := ExtendFunctorToHomotopyCategories( J, false );
      
    else
      
      J := ExtendFunctorToHomotopyCategories( J, true );
      
    fi;
    
    eta_J := CommutativityNaturalTransformationWithShiftFunctor( J );
    
    G := ReplacementFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( collection );
    
    eta_G := CommutativityNaturalTransformationWithShiftFunctor( G );

    GJ := PreCompose( G, J );
    
    sigma_S := ShiftFunctor( SourceOfFunctor( GJ ) );
    
    sigma_T := ShiftFunctor( RangeOfFunctor( GJ ) );
    
    GJ_o_sigma_S := PostCompose( GJ, sigma_S );
    
    sigma_T_o_GJ := PostCompose( sigma_T, GJ );
    
    eta := NaturalTransformation( "Natural isomorphism G o Σ => Σ o G", GJ_o_sigma_S, sigma_T_o_GJ );
    
    AddNaturalTransformationFunction( eta,
      function( GJ_o_sigma_S_a, a, sigma_T_o_GJ_a )
        
        return PreCompose(
                  ApplyFunctor( J, ApplyNaturalTransformation( eta_G, a ) ),
                  ApplyNaturalTransformation( eta_J, ApplyFunctor( G, a ) )
                );
                
    end );
    
    SetCommutativityNaturalTransformationWithShiftFunctor( GJ, eta );
    
    GJ!.Name := "Replacement functor";
    
    return GJ;
   
end );

BindGlobal( "SET_COMMUTATIVITY_NAT_ISO_BETWEEN_CONVOLUTION_AND_SHIFT",
  function( collection, conv )
    local D, sigma_D, C, sigma_C, conv_o_sigma_D, sigma_C_o_conv, name, eta;
    
    C := AmbientCategory( collection );
    
    D := HomotopyCategory( collection );
    
    sigma_D := ShiftFunctor( D );
     
    sigma_C := ShiftFunctor( C );
    
    conv_o_sigma_D := PostCompose( conv, sigma_D );
    
    sigma_C_o_conv := PostCompose( sigma_C, conv );
    
    name := "Natural isomorphism F o Σ => Σ o F";
    
    eta := NaturalTransformation( name, conv_o_sigma_D, sigma_C_o_conv );
    
    AddNaturalTransformationFunction( eta,
      function( conv_o_sigma_D_a, a, sigma_C_o_conv_a )
        local diffs, b, z_func, alpha;
        
        diffs := Differentials( a );
        
        diffs := ApplyMap( diffs, AdditiveInverse );
        
        b := HomotopyCategoryObject( D, diffs );
        
        SetLowerBound( b, ActiveLowerBound( a ) );
        
        SetUpperBound( b, ActiveUpperBound( a ) );
        
        z_func := AsZFunction( i -> ( -1 ) ^ i * IdentityMorphism( a[ i ] ) );
        
        alpha := HomotopyCategoryMorphism( a, b, z_func );
        
        alpha := conv_o_sigma_D( alpha );
                
        return alpha;
        
    end );
    
    SetCommutativityNaturalTransformationWithShiftFunctor( conv, eta );
   
end );

##
InstallMethod( ConvolutionFunctor,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, complexes_cat, homotopy_cat, conv;
     
    ambient_cat := AmbientCategory( collection );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if IsCochainComplexCategory( complexes_cat ) or IsChainComplexCategory( complexes_cat ) then
      
      homotopy_cat := HomotopyCategory( collection );
      
    else
      
      Error( "The ambient category of the collection should be a homotopy category!\n" );
      
    fi;

    conv := CapFunctor( "Convolution functor", homotopy_cat, ambient_cat );
    
    AddObjectFunction( conv, BackwardConvolution );
    
    AddMorphismFunction( conv, { s, alpha, r } -> BackwardConvolution( alpha ) );
    
    SET_COMMUTATIVITY_NAT_ISO_BETWEEN_CONVOLUTION_AND_SHIFT( collection, conv );
    
    return conv;
    
end );

##
InstallMethod( ConvolutionFunctorFromHomotopyCategoryOfAdditiveClosureOfAlgebroid,
    [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, complexes_cat, I, eta_I, F, eta_F, IF, sigma_S, sigma_T, IF_o_sigma_S, sigma_T_o_IF, eta;
    
    ambient_cat := AmbientCategory( collection );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    I := IsomorphismFromAlgebroid( collection );
    
    I := ExtendFunctorToAdditiveClosureOfSource( I );
    
    if IsChainComplexCategory( complexes_cat ) then
      
      I := ExtendFunctorToHomotopyCategories( I, false );
      
    else
      
      I := ExtendFunctorToHomotopyCategories( I, true );
      
    fi;
    
    eta_I := CommutativityNaturalTransformationWithShiftFunctor( I );
    
    F := ConvolutionFunctor( collection );
    
    eta_F := CommutativityNaturalTransformationWithShiftFunctor( F );
    
    IF := PreCompose( I, F );
    
    sigma_S := ShiftFunctor( SourceOfFunctor( IF ) );

    sigma_T := ShiftFunctor( RangeOfFunctor( IF ) );

    IF_o_sigma_S := PostCompose( IF, sigma_S );

    sigma_T_o_IF := PostCompose( sigma_T, IF );

    eta := NaturalTransformation( "Natural isomorphism F o Σ => Σ o F", IF_o_sigma_S, sigma_T_o_IF );
    
    AddNaturalTransformationFunction( eta,
      function( IF_o_sigma_S_a, a, sigma_T_o_IF_a )
      
        return PreCompose(
                  ApplyFunctor( F, ApplyNaturalTransformation( eta_I, a ) ),
                  ApplyNaturalTransformation( eta_F, ApplyFunctor( I, a ) )
                );
        
    end );
    
    SetCommutativityNaturalTransformationWithShiftFunctor( IF, eta );
    
    IF!.Name := "Convolution functor";
    
    return IF;
    
end );

##
InstallMethod( ConvolutionFunctorFromHomotopyCategoryOfQuiverRows,
    [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, complexes_cat, oid, oid_plus, I, eta_I, F, eta_F, IF, sigma_S, sigma_T, IF_o_sigma_S, sigma_T_o_IF, eta;
    
    ambient_cat := AmbientCategory( collection );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
   
    oid := Algebroid( collection );
    
    oid_plus := AdditiveClosure( oid );
    
    I := IsomorphismFromQuiverRows( oid_plus );
    
    if IsChainComplexCategory( complexes_cat ) then
      
      I := ExtendFunctorToHomotopyCategories( I, false );
      
    else
      
      I := ExtendFunctorToHomotopyCategories( I, true );
      
    fi;
     
    eta_I := CommutativityNaturalTransformationWithShiftFunctor( I );
    
    F := ConvolutionFunctorFromHomotopyCategoryOfAdditiveClosureOfAlgebroid( collection );
    
    eta_F := CommutativityNaturalTransformationWithShiftFunctor( F );
    
    IF := PreCompose( I, F );
    
    sigma_S := ShiftFunctor( SourceOfFunctor( IF ) );

    sigma_T := ShiftFunctor( RangeOfFunctor( IF ) );

    IF_o_sigma_S := PostCompose( IF, sigma_S );

    sigma_T_o_IF := PostCompose( sigma_T, IF );

    eta := NaturalTransformation( "Natural isomorphism F o Σ => Σ o F", IF_o_sigma_S, sigma_T_o_IF );
    
    AddNaturalTransformationFunction( eta,
      function( IF_o_sigma_S_a, a, sigma_T_o_IF_a )
      
        return PreCompose(
                  ApplyFunctor( F, ApplyNaturalTransformation( eta_I, a ) ),
                  ApplyNaturalTransformation( eta_F, ApplyFunctor( I, a ) )
                );
        
    end );
    
    SetCommutativityNaturalTransformationWithShiftFunctor( IF, eta );
    
    IF!.Name := "Convolution functor";
    
    return IF;
    
end );

##
AddFunctor(
    IsHomotopyCategory,
    IsHomotopyCategory,
    { category_1, category_2 }
          -> IsAdditiveClosureCategory( DefiningCategory( category_1 ) ) and
              IsAdditiveClosureCategory( DefiningCategory( category_2 ) ) and
                HasStrongExceptionalCollection( UnderlyingCategory( DefiningCategory( category_1 ) ) ) and
                  IsIdenticalObj( category_2, AmbientCategory( StrongExceptionalCollection( UnderlyingCategory( DefiningCategory( category_1 ) ) ) ) ),
    function( category_1, category_2 )
      local collection;
      
      collection := StrongExceptionalCollection( UnderlyingCategory( DefiningCategory( category_1 ) ) );
      
      return ConvolutionFunctor( collection );
      
    end,
    "Convolution functor",
    "Convolution functor"
);
     
##
AddFunctor(
    IsHomotopyCategory,
    IsHomotopyCategory,
    { category_2, category_1 }
          -> IsAdditiveClosureCategory( DefiningCategory( category_1 ) ) and
              IsAdditiveClosureCategory( DefiningCategory( category_2 ) ) and
                HasStrongExceptionalCollection( UnderlyingCategory( DefiningCategory( category_1 ) ) ) and
                  IsIdenticalObj( category_2, AmbientCategory( StrongExceptionalCollection( UnderlyingCategory( DefiningCategory( category_1 ) ) ) ) ),
    function( category_2, category_1 )
      local collection;
      
      collection := StrongExceptionalCollection( UnderlyingCategory( DefiningCategory( category_1 ) ) );
      
      return ReplacementFunctor( collection );
      
    end,
    "Replacement functor",
    "Replacement functor"
);

####################################
#
# Inverse of isomorphism functors
# Between k-linear categories with
# homomorphism structure
#
####################################

##
InstallMethod( ImageOfFunctor,
          [ IsCapFunctor ],
  function( I )
    local C, R, images_obj_C, r, name, full;
    
    C := SourceOfFunctor( I );
    
    R := RangeOfFunctor( I );
    
    if IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects( C ) then
      
      images_obj_C := List( SetOfKnownObjects( C ), I );
      
    elif IsAlgebroid( C ) then
      
      images_obj_C := List( SetOfObjects( C ), I );
      
    else
      
      TryNextMethod( );
      
    fi;
    
    r := RandomTextColor( Name( R ) );
    
    name := Concatenation( r[ 1 ], "Full subcategory( ", r[ 2 ], Name( R ), r[ 1 ],
        " ) generated by values of a functor on ", String( Length( images_obj_C ) ), " objects", r[ 2 ] );
        
    full := FullSubcategoryGeneratedByListOfObjects( images_obj_C : name_of_full_subcategory := name );
    
    SetDefiningFunctor( full, I );
    
    return full;
    
end );

##
InstallMethod( ImageOfFullyFaithfullFunctor,
          [ IsCapFunctor ],
  function( I )
    local R, image, r, name;
    
    R := RangeOfFunctor( I );
    
    r := RandomTextColor( Name( R ) );
        
    image := ImageOfFunctor( I );
    
    SetDefiningFullyFaithfulFunctor( image, I );
    
    name := Concatenation( r[ 1 ], "Full subcategory( ", r[ 2 ], Name( R ), r[ 1 ],
        " ) generated by values of a fully faithfull functor on ", String( Length( SetOfKnownObjects( image ) ) ), " objects", r[ 2 ] );

    
    image!.Name := name;
    
    return image;
    
end );

##
InstallMethod( IsomorphismOntoImageOfFullyFaithfulFunctor,
          [ IsCapFunctor ],
  function( I )
    local C, D, r, name;
    
    C := SourceOfFunctor( I );
    
    if not ( IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects( C )
              or IsAlgebroid( C ) ) then
      
      TryNextMethod( );
      
    fi;
    
    D := ImageOfFullyFaithfullFunctor( I );
    
    r := RandomTextColor( Name( I ) );
    
    name := Concatenation( r[ 1 ], "Isomorphism functor onto the image ( ", r[ 2 ],
              Name( I ), r[ 1 ], " ) ", r[ 2 ]
              );
              
    I := RestrictFunctorToFullSubcategoryOfRange( I, D );
    
    I!.Name := name;
    
    return I;
    
end );

##
InstallMethod( IsomorphismFromImageOfFullyFaithfulFunctor,
          [ IsCapFunctor ],
  function( I )
    local C, D, object_func, images_of_morphisms_D, morphism_func, r, name, ring, coeffs;
    
    C := SourceOfFunctor( I );
     
    if not ( IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects( C )
              or IsAlgebroid( C ) ) then
      
      TryNextMethod( );
      
    fi;
    
    D := ImageOfFullyFaithfullFunctor( I );
    
    if IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects( C ) then
      
      object_func := o -> SetOfKnownObjects( C )[ Position( SetOfKnownObjects( D ), o ) ];
      
    else
      
      object_func := o -> SetOfObjects( C )[ Position( SetOfKnownObjects( D ), o ) ];
      
    fi;
    
    ring := CommutativeRingOfLinearCategory( C );
    
    images_of_morphisms_D := [ [ ], [ ] ];
    
    morphism_func :=
      function( alpha )
        local a, b, pre_a, pre_b, p, B_pre_a_pre_b, B_a_b, morphism_1, I_B_pre_a_pre_b, morphism_2, lift, coeffs;
        
        a := Source( alpha );
        
        b := Range( alpha );
        
        B_a_b := BasisOfExternalHom( a, b );
        
        pre_a := object_func( a );
        
        pre_b := object_func( b );
        
        p := Position( images_of_morphisms_D[ 1 ], [ a, b ] );
        
        if p = fail then
          
          B_pre_a_pre_b := BasisOfExternalHom( pre_a, pre_b );
          
          morphism_1 := InterpretListOfMorphismsAsOneMorphismInRangeCategoryOfHomomorphismStructure( a, b, B_a_b );
          
          I_B_pre_a_pre_b := List( B_pre_a_pre_b, m -> I( m ) / D );
          
          morphism_2 := InterpretListOfMorphismsAsOneMorphismInRangeCategoryOfHomomorphismStructure( a, b, I_B_pre_a_pre_b );
          
          lift := Lift( morphism_1, morphism_2 );
          
          coeffs := EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( lift ) * ring );
          
          Add( images_of_morphisms_D[ 1 ], [ a, b ] );
          
          Add( images_of_morphisms_D[ 2 ], List( coeffs, c -> c * B_pre_a_pre_b ) );
          
          p := Length( images_of_morphisms_D[ 1 ] );
          
        fi;
        
        coeffs := CoefficientsOfMorphism( alpha );
        
        return List( coeffs, c -> c / ring ) * images_of_morphisms_D[ 2 ][ p ];
        
    end;
    
    r := RandomTextColor( Name( I ) );
    
    name := Concatenation( r[ 1 ], "Isomorphism functor from the image ( ", r[ 2 ],
              Name( I ), r[ 1 ], " ) ", r[ 2 ]
              );
              
    return CreateAdditiveFunctorByTwoFunctions( name, D, C, object_func, morphism_func );
    
end );

###################################
#
# Embedding in derived category
#
###################################

##
InstallOtherMethod( EquivalenceOntoDerivedCategory,
          [ IsStrongExceptionalCollection ],
  
  function( collection )
    local ambient_cat, over_cochains, abs, I;
    
    ambient_cat := AmbientCategory( collection );
    
    if IsCochainComplexCategory( UnderlyingCategory( ambient_cat ) ) then
      over_cochains := true;
    else
      over_cochains := false;
    fi;
    
    abs := IsomorphismOntoAlgebroid( collection );
    abs := ExtendFunctorToAdditiveClosures( abs );
    abs := ExtendFunctorToHomotopyCategories( abs, over_cochains );
    
    I := EquivalenceOntoDerivedCategory( RangeOfFunctor( abs ) );
    I := PreCompose( abs, I );
    
    I!.Name := "Equivalence functor onto derived category of endomorphism algebra";
    
    return I;
    
end );

##
InstallMethod( EquivalenceOntoDerivedCategory,
          [ IsHomotopyCategory ],
          
  function( homotopy_cat )
    local over_cochains, D, A, I, J, F, U, CP, N, objs, collection, full, name, k, A_oid, AA_oid;
    
    over_cochains := IsCochainComplexCategory( UnderlyingCategory( homotopy_cat ) );
    
    D := DefiningCategory( homotopy_cat );
    
    if IsCapFullSubcategory( D ) and HasIsAdditiveCategory( D ) and IsAdditiveCategory( D ) then
        
        A := AmbientCategory( D );
        
        if HasIsAbelianCategory( A ) and IsAbelianCategory( A ) then
          
          I := InclusionFunctor( D );
          
          I := ExtendFunctorToHomotopyCategories( I, over_cochains );
          
          J := LocalizationFunctor( RangeOfFunctor( I ) );
          
          F := PreCompose( I, J );
          
          F!.Name := "Equivalence functor from homotopy category onto derived category";
          
          return F;
          
        else
          
          return fail;
          
        fi;
        
    elif IsAdditiveClosureCategory( D ) then
      
      U := UnderlyingCategory( D );
      
      if IsAlgebroid( U ) then
        
        A := UnderlyingQuiverAlgebra( U );
        
        if not ( IsAdmissibleQuiverAlgebra( A ) and IsAcyclicQuiver( QuiverOfAlgebra( A ) ) ) then
          
          return fail;
          
        fi;
        
        I := YonedaIsomorphismOntoFullSubcategoryOfCategoryOfFunctors( U );
        
        I := PreCompose( I, InclusionFunctor( RangeOfFunctor( I ) ) );
        
        I := ExtendFunctorToAdditiveClosureOfSource( I );
        
        I := ExtendFunctorToHomotopyCategories( I, over_cochains );
        
        J := LocalizationFunctor( RangeOfFunctor( I ) );
        
        F := PreCompose( I, J );
        
        F!.Name := "Equivalence functor from homotopy category onto derived category";
        
        return F;
        
      elif IsLinearClosure( U ) and IsProSetAsCategory( UnderlyingCategory( U ) ) then
        
        CP := UnderlyingCategory( U );
        
        N := Length( IncidenceMatrix( CP )[ 1 ] );
        
        objs := List( [ 1 .. N ], i -> LinearClosureObject( U, i/CP ) );
        
        collection := CreateStrongExceptionalCollection( objs );
        
        full := FullSubcategory( collection );
        
        name := "Isomorphism functor from ProSetAsCategory onto full subcategory generated by all its objects" ;
        
        I := CapFunctor( name, U, full );
        
        AddObjectFunction( I, a -> a / full );
        
        AddMorphismFunction( I, { s, alpha, r } -> alpha / full );
        
        I := PreCompose( I, IsomorphismOntoAlgebroid( collection ) );
        
        I := ExtendFunctorToAdditiveClosures( I );
        
        I := ExtendFunctorToHomotopyCategories( I, over_cochains );
        
        J := EquivalenceOntoDerivedCategory( RangeOfFunctor( I ) );
        
        return PreCompose( I, J );
        
      else
        
        return fail;
        
      fi;
      
    elif IsQuiverRowsCategory( D ) then
      
      A := UnderlyingQuiverAlgebra( D );
      
      k := CommutativeRingOfLinearCategory( D );
      
      if ( HasIsFieldForHomalg( k ) and IsFieldForHomalg( k ) ) or IsRationals( k ) then
        
        A_oid := Algebroid( A : range_of_HomStructure := MatrixCategory( k ) );
        
      else
        
        return fail;
        
      fi;
      
      AA_oid := AdditiveClosure( A_oid );
      
      I := IsomorphismFromQuiverRowsIntoAdditiveClosureOfAlgebroid( D, AA_oid );
      
      I := ExtendFunctorToHomotopyCategories( I, over_cochains );
      
      F := EquivalenceOntoDerivedCategory( HomotopyCategory( AA_oid, over_cochains ) );
      
      F := PreCompose( I, F );
      
      F!.Name := "Equivalence functor from homotopy category onto derived category";
      
      return F;
      
    else
      
      return fail;
      
    fi;
    
end );

##
InstallMethod( EquivalenceOntoDerivedCategoryOfQuiverRepresentations,
          [ IsHomotopyCategory ],
          
  function( homotopy_cat )
    local over_cochains, D, A, I, J, F, U, CP, N, objs, collection, full, name, k, A_oid, AA_oid;
    
    over_cochains := IsCochainComplexCategory( UnderlyingCategory( homotopy_cat ) );
    
    D := DefiningCategory( homotopy_cat );
    
    if IsCapFullSubcategory( D ) and HasIsAdditiveCategory( D ) and IsAdditiveCategory( D ) then
      
      A := AmbientCategory( D );
      
      if HasIsAbelianCategory( A ) and IsAbelianCategory( A ) then
        
        I := InclusionFunctor( D );
        
        I := ExtendFunctorToHomotopyCategories( I, over_cochains );
        
        J := LocalizationFunctor( RangeOfFunctor( I ) );
        
        F := PreCompose( I, J );
        
        F!.Name := "Equivalence functor from homotopy category onto derived category";
        
        return F;
        
      else
        
        return fail;
        
      fi;
      
    elif IsAdditiveClosureCategory( D ) then
      
      U := UnderlyingCategory( D );
      
      if IsAlgebroid( U ) then
        
        A := UnderlyingQuiverAlgebra( U );
        
        if not ( IsAdmissibleQuiverAlgebra( A ) and IsAcyclicQuiver( QuiverOfAlgebra( A ) ) ) then
          
          return fail;
          
        fi;
        
        I := YonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( U );
        
        I := PreCompose( I, InclusionFunctor( RangeOfFunctor( I ) ) );
        
        I := ExtendFunctorToAdditiveClosureOfSource( I );
        
        I := ExtendFunctorToHomotopyCategories( I, over_cochains );
        
        J := LocalizationFunctor( RangeOfFunctor( I ) );
        
        F := PreCompose( I, J );
        
        F!.Name := "Equivalence functor from homotopy category onto derived category";
        
        return F;
        
      elif IsLinearClosure( U ) and IsProSetAsCategory( UnderlyingCategory( U ) ) then
        
        CP := UnderlyingCategory( U );
        
        N := Length( IncidenceMatrix( CP )[ 1 ] );
        
        objs := List( [ 1 .. N ], i -> LinearClosureObject( U, i/CP ) );
        
        collection := CreateStrongExceptionalCollection( objs );
        
        full := FullSubcategory( collection );
        
        name := "Isomorphism functor from ProSetAsCategory onto full subcategory generated by all its objects" ;
        
        I := CapFunctor( name, U, full );
        
        AddObjectFunction( I, a -> a / full );
        
        AddMorphismFunction( I, { s, alpha, r } -> alpha / full );
        
        I := PreCompose( I, IsomorphismOntoAlgebroid( collection ) );
        
        I := ExtendFunctorToAdditiveClosures( I );
        
        I := ExtendFunctorToHomotopyCategories( I, over_cochains );
        
        J := EquivalenceOntoDerivedCategoryOfQuiverRepresentations( RangeOfFunctor( I ) );
        
        return PreCompose( I, J );
        
      else
        
        return fail;
        
      fi;
      
    elif IsQuiverRowsCategory( D ) then
      
      A := UnderlyingQuiverAlgebra( D );
      
      k := CommutativeRingOfLinearCategory( D );
      
      if ( HasIsFieldForHomalg( k ) and IsFieldForHomalg( k ) ) or IsRationals( k ) then
        
        A_oid := Algebroid( A: range_of_HomStructure := MatrixCategory( k ) );
        
      else
        
        return fail;
        
      fi;
      
      AA_oid := AdditiveClosure( A_oid );
      
      I := IsomorphismFromQuiverRowsIntoAdditiveClosureOfAlgebroid( D, AA_oid );
      
      I := ExtendFunctorToHomotopyCategories( I );
      
      F := EquivalenceOntoDerivedCategoryOfQuiverRepresentations( HomotopyCategory( AA_oid, over_cochains ) );
      
      F := PreCompose( I, F );
      
      F!.Name := "Equivalence functor from homotopy category onto derived category";
      
      return F;
      
    else
      
      return fail;
      
    fi;
    
end );

######################################
#
# F_1 : algebroid_1 -> full subcategory 1
# F_2 : algebroid_2 -> full subcategory 2
#
######################################

##
InstallMethodWithCrispCache( IsomorphismFromTensorProductOfAlgebroidsOntoBoxProductOfFullSubcategories,
          [ IsCapFunctor, IsCapFunctor, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects ],
  function( F_1, F_2, box_product_full_subcategory )
    local ring, algebroid_1, A_1, algebroid_2, A_2, algebroid, func_on_object, func_on_morphism, name;
    
    ring := CommutativeRingOfLinearCategory( box_product_full_subcategory );
    
    algebroid_1 := SourceOfFunctor( F_1 );
    
    algebroid_2 := SourceOfFunctor( F_2 );
    
    if not ( IsAlgebroid( algebroid_1 ) and IsAlgebroid( algebroid_2 ) ) then
      Error( "Wrong input!\n" );
    fi;
    
    A_1 := UnderlyingQuiverAlgebra( algebroid_1 );
    
    A_2 := UnderlyingQuiverAlgebra( algebroid_2 );
    
    algebroid := TensorProductOnObjects( algebroid_1, algebroid_2 );
    
    func_on_object :=
      function( o )
        local factors;
        
        factors := ProductPathFactors( UnderlyingVertex( o ) );
        
        return BoxProduct(
                  ApplyFunctor( F_1, factors[ 1 ] / algebroid_1 ),
                  ApplyFunctor( F_2, factors[ 2 ] / algebroid_2 ),
                  box_product_full_subcategory
                );
      end;
    
    func_on_morphism :=
      function( alpha )
        local dec, L, p, i, j;
      
        dec := DecompositionOfMorphismInAlgebroid( alpha );
        
        if IsEmpty( dec ) then
          return ZeroMorphism( func_on_object( Source( alpha ) ), func_on_object( Range( alpha ) ) );
        fi;
        
        L := [ ];
        
        for i in [ 1 .. Length( dec ) ] do
          
          L[ i ] := [ dec[ i ][ 1 ] / ring, [ ] ];
          
          for j in [ 1 .. Length( dec[ i ][ 2 ] ) ] do
            
            p := Paths( Representative( UnderlyingQuiverAlgebraElement( dec[ i ][ 2 ][ j ] ) ) );
            
            if not Length( p ) = 1 then
              Error( "This should not happen!\n" );
            fi;
            
            p := p[ 1 ];
            
            p := ListN( [ algebroid_1, algebroid_2 ], [ A_1, A_2 ], ProductPathFactors( p ),
                    { algebroid, algebra, a } -> algebra.( String( a ) ) / algebroid
                  );
             
            L[ i ][ 2 ][ j ] :=
               BoxProduct(
                    ApplyFunctor( F_1, p[ 1 ] ),
                    ApplyFunctor( F_2, p[ 2 ] ),
                    box_product_full_subcategory
                  );
                  
          od;
            
        od;
        
        return Sum( List( L, l -> MultiplyWithElementOfCommutativeRingForMorphisms( l[ 1 ], PreCompose( l[ 2 ] ) ) ) );
        
      end;
      
    name := "Evaluation functor from tensor product of algebroids onto full subcategory defined by a box product";
    
    return CreateAdditiveFunctorByTwoFunctions( name, algebroid, box_product_full_subcategory, func_on_object, func_on_morphism );
      
end );

##
InstallOtherMethod( IsomorphismFromTensorProductOfAlgebroidsOntoBoxProductOfFullSubcategories,
      [ IsCapFunctor, IsCapFunctor, IsStrongExceptionalCollection ],
  { F_1, F_2, collection } -> IsomorphismFromTensorProductOfAlgebroidsOntoBoxProductOfFullSubcategories( F_1, F_2, FullSubcategory( collection ) )
);

##
InstallMethodWithCrispCache( IsomorphismFromBoxProductOfFullSubcategoriesOntoTensorProductOfAlgebroids,
          [ IsCapFunctor, IsCapFunctor, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects ],
  function( F_1, F_2, box_product_full_subcategory )
    local V, name, F;
    
    V := IsomorphismFromTensorProductOfAlgebroidsOntoBoxProductOfFullSubcategories( F_1, F_2, box_product_full_subcategory );
    
    V := IsomorphismFromImageOfFullyFaithfulFunctor( V );
    
    name := "Abstraction functor from full subcategory defined by a box product onto tensor product of algebroids";
    
    F := CapFunctor( name, AmbientCategory( SourceOfFunctor( V ) ), RangeOfFunctor( V ) );
    
    AddObjectFunction( F,
      o -> ApplyFunctor( V,  o / SourceOfFunctor( V ) )
    );
    
    AddMorphismFunction( F,
      { s, alpha, r } -> ApplyFunctor( V,  alpha / SourceOfFunctor( V ) )
    );
    
    return F;
    
end );

##
InstallOtherMethod( IsomorphismFromBoxProductOfFullSubcategoriesOntoTensorProductOfAlgebroids,
      [ IsCapFunctor, IsCapFunctor, IsStrongExceptionalCollection ],
  { F_1, F_2, collection } -> IsomorphismFromBoxProductOfFullSubcategoriesOntoTensorProductOfAlgebroids( F_1, F_2, FullSubcategory( collection ) )
);


BindGlobal( "EquivalenceFromAdditiveClosureOfIndecomposableProjectiveObjectsIntoFullSubcategoryGeneratedByProjectiveObjects",
  function (o)
    Error(
      Concatenation( "WARNING: EquivalenceFromAdditiveClosureOfIndecomposableProjectiveObjectsIntoFullSubcategoryGeneratedByProjectiveObjects is deprecated \n",
      "Please use QuasiInverseOfDecompositionFunctorOfProjectiveQuiverRepresentations instead"
      ) );
end );

BindGlobal( "EquivalenceFromAdditiveClosureOfIndecomposableInjectiveObjectsIntoFullSubcategoryGeneratedByInjectiveObjects",
  function (o)
    Error(
      Concatenation( "WARNING: EquivalenceFromAdditiveClosureOfIndecomposableInjectiveObjectsIntoFullSubcategoryGeneratedByInjectiveObjects is deprecated \n",
      "Please use QuasiInverseOfDecompositionFunctorOfInjectiveQuiverRepresentations instead"
      ) );
end );

BindGlobal( "EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecomposableProjectiveObjects",
  function (o)
    Error(
      Concatenation( "WARNING: EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecomposableProjectiveObjects is deprecated \n",
      "Please use DecompositionFunctorOfProjectiveQuiverRepresentations instead"
      ) );
end );

BindGlobal( "EquivalenceFromFullSubcategoryGeneratedByInjectiveObjectsIntoAdditiveClosureOfIndecomposableInjectiveObjects",
  function (o)
    Error(
      Concatenation( "WARNING: EquivalenceFromFullSubcategoryGeneratedByInjectiveObjectsIntoAdditiveClosureOfIndecomposableInjectiveObjects is deprecated \n",
      "Please use DecompositionFunctorOfInjectiveQuiverRepresentations instead"
      ) );
end );

BindGlobal( "IsomorphismOntoFullSubcategoryGeneratedByIndecomposableProjRepresentationsOverOppositeAlgebra",
  function (o)
    Error(
      Concatenation( "WARNING: IsomorphismOntoFullSubcategoryGeneratedByIndecomposableProjRepresentationsOverOppositeAlgebra is deprecated \n",
      "Please use YonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations instead"
      ) );
end );

BindGlobal( "IsomorphismFromFullSubcategoryGeneratedByIndecomposableProjRepresentationsOverOppositeAlgebra",
  function (o)
    Error(
      Concatenation( "WARNING: IsomorphismFromFullSubcategoryGeneratedByIndecomposableProjRepresentationsOverOppositeAlgebra is deprecated \n",
      "Please use InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations instead"
      ) );
end );
