# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#

DeclareCategory( "IsDgComplexMorphism", IsCapCategoryMorphism );
DeclareCategory( "IsDgChainComplexMorphism", IsDgComplexMorphism );
DeclareCategory( "IsDgCochainComplexMorphism", IsDgComplexMorphism );

DeclareCategory( "IsBoundedBelowDgComplexMorphism", IsDgComplexMorphism );
DeclareCategory( "IsBoundedAboveDgComplexMorphism", IsDgComplexMorphism );
DeclareCategory( "IsBoundedDgComplexMorphism", IsBoundedBelowDgComplexMorphism and IsBoundedAboveDgComplexMorphism );

DeclareCategory( "IsBoundedBelowDgChainComplexMorphism", IsBoundedBelowDgComplexMorphism and IsDgChainComplexMorphism ); 
DeclareCategory( "IsBoundedAboveDgChainComplexMorphism", IsBoundedAboveDgComplexMorphism and IsDgChainComplexMorphism );
DeclareCategory( "IsBoundedDgChainComplexMorphism", IsBoundedDgComplexMorphism and IsDgChainComplexMorphism );

DeclareCategory( "IsBoundedBelowDgCochainComplexMorphism", IsBoundedBelowDgComplexMorphism and IsDgCochainComplexMorphism );
DeclareCategory( "IsBoundedAboveDgCochainComplexMorphism", IsBoundedAboveDgComplexMorphism and IsDgCochainComplexMorphism );
DeclareCategory( "IsBoundedDgCochainComplexMorphism", IsBoundedDgComplexMorphism and IsDgCochainComplexMorphism );




DeclareOperation( "DgCochainComplexMorphism", [ IsDgCochainComplex, IsDgCochainComplex, IsInt, IsZFunction ] );
DeclareOperation( "DgCochainComplexMorphism", [ IsDgCochainComplex, IsDgCochainComplex, IsInt, IsZFunction, IsInt, IsInt ] );

DeclareOperation( "DgCochainComplexMorphism", [ IsDgCochainComplex, IsDgCochainComplex, IsInt, IsDenseList, IsInt ] );


DeclareAttribute( "DegreeOfDgComplexMorphism", IsDgComplexMorphism );

DeclareAttribute( "Differential", IsDgComplexMorphism );

DeclareProperty( "IsClosedDgComplexMorphism", IsDgComplexMorphism );
DeclareProperty( "IsClosedDgComplexMorphismInDegreeZero", IsDgComplexMorphism );

DeclareProperty( "IsExactDgComplexMorphism", IsDgComplexMorphism );
DeclareProperty( "IsExactDgComplexMorphismInDegreeZero", IsDgComplexMorphism );

DeclareAttribute( "WitnessForExactnessOfDgComplexMorphism", IsDgComplexMorphism );



DeclareAttribute( "Morphisms", IsDgComplexMorphism );
KeyDependentOperation( "MorphismAt", IsDgComplexMorphism, IsInt, ReturnTrue );
DeclareOperation( "\[\]", [ IsDgComplexMorphism, IsInt ] );

DeclareAttribute( "UpperBoundOfDgComplexMorphism", IsDgComplexMorphism );
DeclareAttribute( "LowerBoundOfDgComplexMorphism", IsDgComplexMorphism );

DeclareOperation( "Display", [ IsDgComplexMorphism, IsInt, IsInt ] );
