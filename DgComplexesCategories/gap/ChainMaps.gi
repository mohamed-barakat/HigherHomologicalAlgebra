# SPDX-License-Identifier: GPL-2.0-or-later
# DgComplexesCategories: Category of graded (co)chain complexes of an additive category
#
# Implementations
#

DeclareRepresentation( "IsDgChainComplexMorphismRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [] );

DeclareRepresentation( "IsDgCochainMorphismRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [] );

BindGlobal( "FamilyOfDgChainComplexMorphisms",
            NewFamily( "dg chain morphisms" ) );


BindGlobal( "FamilyOfDgCochainComplexMorphisms",
            NewFamily( "dg cochain morphisms" ) );

BindGlobal( "TheTypeOfDgChainMorphisms",
            NewType( FamilyOfDgChainComplexMorphisms,
                     IsDgChainComplexMorphism and IsDgChainComplexMorphismRep ) );

BindGlobal( "TheTypeOfDgCochainMorphisms",
            NewType( FamilyOfDgCochainComplexMorphisms,
                     IsDgCochainComplexMorphism and IsDgCochainMorphismRep ) );


##
InstallMethod( DgCochainComplexMorphism,
            [IsDgCochainComplex, IsDgCochainComplex, IsInt, IsZFunction, IsInt, IsInt ],

  function ( S, R, degree, morphisms, lower_bound, upper_bound )

    return CreateCapCategoryMorphismWithAttributes( CapCategory( S ),
            S,
            R,
            Morphisms, morphisms,
            DegreeOfDgComplexMorphism, degree,
            LowerBoundOfDgComplexMorphism, lower_bound,
            UpperBoundOfDgComplexMorphism, upper_bound
            );
end );

##
InstallMethod( DgCochainComplexMorphism,
            [IsDgCochainComplex, IsDgCochainComplex, IsInt, IsZFunction ],

  function ( S, R, degree, morphisms )

    return CreateCapCategoryMorphismWithAttributes( CapCategory( S ),
            S,
            R,
            Morphisms, morphisms,
            DegreeOfDgComplexMorphism, degree,
            LowerBoundOfDgComplexMorphism, Minimum( LowerBoundOfDgComplex( S ), LowerBoundOfDgComplex( R ) ),
            UpperBoundOfDgComplexMorphism, Maximum( UpperBoundOfDgComplex( S ), UpperBoundOfDgComplex( R ) )
            );
end );

##
InstallMethod( DgCochainComplexMorphism,
        [IsDgCochainComplex, IsDgCochainComplex, IsInt, IsDenseList, IsInt ],
  function( S, R, degree, mors, lower_bound )
  local z_func, phi;

  z_func :=
    AsZFunction(
        function( i )
          if i >= lower_bound and i <= lower_bound + Length( mors ) - 1 then
            return mors[i - lower_bound + 1];
          else
            return ZeroMorphism( S[i], R[i + degree] );
          fi;
         end );

  return DgCochainComplexMorphism( S, R, degree, z_func, lower_bound, lower_bound + Length( mors ) - 1 );

end );

##
InstallMethod( Differential,
            [ IsDgCochainComplexMorphism ],
          
  phi -> DgCochainComplexMorphism(
                Source( phi ),
                Range( phi ),
                DegreeOfDgComplexMorphism( phi ) + 1,
                AsZFunction( i -> PreCompose( Source( phi )^i, phi[i + 1] ) - (-1)^DegreeOfDgComplexMorphism( phi ) * PreCompose( phi[i], Range( phi )^( i + DegreeOfDgComplexMorphism( phi ) ) ) )
            )
);

##
InstallMethod( IsClosedDgComplexMorphism,
            [ IsDgComplexMorphism ],
            
  function( phi )
    local D_phi;
    
    D_phi := Differential( phi );
    
    return ForAll( [ LowerBoundOfDgComplexMorphism( phi ) .. UpperBoundOfDgComplexMorphism( phi ) ], i -> IsZeroForMorphisms( D_phi[ i ] ) );
end );

##
InstallMethod( IsExactDgComplexMorphism,
            [ IsDgComplexMorphism ],
          
  function( phi )
    local eta;
    
    eta := HomStructure( phi );
    
    return IsZeroForMorphisms( PreCompose( eta[0], CokernelProjection( Range( eta )^( DegreeOfDgComplexMorphism(eta) - 1 ) ) ) );
    
end );

##
InstallMethod( WitnessForExactnessOfDgComplexMorphism,
            [ IsDgComplexMorphism ],
            
  function( phi )
    local cat, range_cat, degree_eta, B, C, h_BC, l, m, eta, zeta;
    
    cat := UnderlyingCategory( CapCategory( phi ) );
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    if not ( HasIsAbelianCategoryWithEnoughProjectives( range_cat ) and IsAbelianCategoryWithEnoughProjectives( range_cat ) ) then
        TryNextMethod( );
    fi;
    
    
    B := Source( phi );
    C := Range( phi );
    
    h_BC := HomStructure( B, C );
    eta := HomStructure( phi );
    degree_eta := DegreeOfDgComplexMorphism( eta );
    
    l := LiftAlongMonomorphism( ImageEmbedding( h_BC ^ ( degree_eta - 1 ) ), eta[ 0 ] );
    m := ProjectiveLift( l, CoastrictionToImage( h_BC ^ ( degree_eta - 1 ) ) );
    
    zeta := DgCochainComplexMorphism( Source( eta ), Range( eta ), degree_eta - 1, [ m ], 0 );
    
    return HomStructure( B, C, zeta );
    
end );

##
InstallMethod( IsClosedDgComplexMorphismInDegreeZero,
            [ IsDgComplexMorphism ],
          
    phi -> DegreeOfDgComplexMorphism( phi ) = 0 and IsClosedDgComplexMorphism( phi )
);

##
InstallMethod( IsExactDgComplexMorphismInDegreeZero,
            [ IsDgComplexMorphism ],
    
    phi -> DegreeOfDgComplexMorphism( phi ) = 0 and IsExactDgComplexMorphism( phi )
);

##
InstallMethod( MorphismAtOp,
            [IsDgComplexMorphism, IsInt ],

  { phi, i } -> Morphisms( phi )[i ]
);

##
InstallMethod( \[\], [IsDgComplexMorphism, IsInt ], MorphismAt );

##
InstallMethod( ViewObj,
            [IsDgComplexMorphism ],

  function( phi )

    if HasLowerBoundOfDgComplexMorphism( phi ) and HasUpperBoundOfDgComplexMorphism( phi ) then

      Print(
        "<A morphism in ",
        Name( CapCategory( phi ) ),
        " of degree ", String( DegreeOfDgComplexMorphism( phi ) ), " with lower bound ",
        LowerBoundOfDgComplexMorphism( phi ),
        " and upper bound ",
        UpperBoundOfDgComplexMorphism( phi ), ">"
        );

    elif HasLowerBoundOfDgComplexMorphism( phi ) then

      Print(
        "<A morphism in ",
        Name( CapCategory( phi ) ),
        " of degree ", String( DegreeOfDgComplexMorphism( phi ) ), " with lower bound ",
        LowerBoundOfDgComplexMorphism( phi ), ">"
        );

    elif HasUpperBoundOfDgComplexMorphism( phi ) then

      Print(
        "<A morphism in ",
        Name( CapCategory( phi ) ),
        " of degree ", String( DegreeOfDgComplexMorphism( phi ) ), " with upper bound ",
        UpperBoundOfDgComplexMorphism( phi ), ">"
        );

    else

      TryNextMethod( );

    fi;

end );

##
InstallMethod( Display,
            [IsDgComplexMorphism, IsInt, IsInt ],

  function( phi, m, n )
    local i;

    for i in Reversed( [m .. n] ) do

      Print( Concatenation( "== ", String( i ), " =======================" ) );
      Print( "\n" );
      Display( phi[i] );
      Print( "\n" );

    od;

    Print( "\nA morphism in ", Name( CapCategory( phi ) ), " of degree ", String( DegreeOfDgComplexMorphism( phi ) ), " given by the above data\n" );

end );

##
InstallMethod( Display,
            [IsDgComplexMorphism ],

  function( phi )

    if HasLowerBoundOfDgComplexMorphism( phi ) and HasUpperBoundOfDgComplexMorphism( phi ) then
        Display( phi, LowerBoundOfDgComplexMorphism( phi ), UpperBoundOfDgComplexMorphism( phi ) );
    else
        TryNextMethod( );
    fi;

end );

##
InstallMethod( LaTeXOutput,
        [ IsDgCochainComplexMorphism ],
        
  function( phi )
    local arrow, l, u, latex_string, i, OnlyDatum;
    
    if DegreeOfDgComplexMorphism( phi ) > 0 then
        arrow := "{}^{\\nearrow}";
    elif DegreeOfDgComplexMorphism( phi ) < 0 then
        arrow := "{}_{\\searrow}";
    else
        arrow := "\\rightarrow";
    fi;
    
    l := Minimum( LowerBoundOfDgComplex( Source( phi ) ), LowerBoundOfDgComplex( Range( phi ) ) );
    u := Maximum( UpperBoundOfDgComplex( Source( phi ) ), UpperBoundOfDgComplex( Range( phi ) ) );
    
    OnlyDatum := ValueOption( "OnlyDatum" );
    
    if OnlyDatum = true then
      
      latex_string := "\\begin{array}{lc}\n ";
      
      for i in Reversed( [ l .. u ] ) do
        
        latex_string := Concatenation( latex_string, "\\\\ \n", String( i ), ": &", LaTeXOutput( phi[ i ] : OnlyDatum := false ), " \\\\ \n " );
        
      od;
      
    else
      
      latex_string := "\\begin{array}{ccc}\n ";
      
      latex_string := Concatenation(
              latex_string,
              LaTeXOutput( Source( phi )[ u ] ),
              "&-{",
              LaTeXOutput( phi[ u ] : OnlyDatum := true ),
              "}", arrow,"&",
              LaTeXOutput( Range( phi )[ u ] ),
              "\n \\\\ \n"
            );
            
      for i in Reversed( [ l .. u - 1 ] ) do
        
        latex_string := Concatenation(
                latex_string,
                " \\uparrow_{\\phantom{", String( i ), "}}",
                "&&",
                " \n \\uparrow_{\\phantom{", String( i ), "}}",
                "\n \\\\ \n "
              );
              
        latex_string := Concatenation(
                latex_string,
                LaTeXOutput( Source( phi ) ^ i : OnlyDatum := true ),
                "&&",
                LaTeXOutput( Range( phi ) ^ i : OnlyDatum := true ),
                "\n \\\\ \n "
              );
              
        latex_string := Concatenation(
                latex_string,
                "\\vert_{", String( i ), "} ",
                "&&",
                "\\vert_{", String( i ), "} ",
                "\n \\\\ \n "
              );
              
        latex_string := Concatenation(
              latex_string,
              LaTeXOutput( Source( phi )[ i ] ),
              "&-{",
              LaTeXOutput( phi[ i ] : OnlyDatum := true ),
              "}", arrow,"&",
              LaTeXOutput( Range( phi )[ i ] ),
              "\n \\\\ \n "
            );
            
      od;
      
    fi;
    
    return Concatenation( latex_string, "\\end{array}" );
    
end );
