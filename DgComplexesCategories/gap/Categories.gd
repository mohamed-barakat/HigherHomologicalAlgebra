# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of graded (co)chain complexes of an additive category
#
# Declarations
#

####################

DeclareCategory( "IsDgChainOrCochainComplexCategory", IsCapCategory );
DeclareCategory( "IsBoundedDgChainOrCochainComplexCategory", IsDgChainOrCochainComplexCategory );

DeclareCategory( "IsDgChainComplexCategory", IsDgChainOrCochainComplexCategory );
DeclareCategory( "IsDgBoundedChainComplexCategory", IsBoundedDgChainOrCochainComplexCategory );

DeclareCategory( "IsDgCochainComplexCategory", IsDgChainOrCochainComplexCategory );
DeclareCategory( "IsDgBoundedCochainComplexCategory", IsBoundedDgChainOrCochainComplexCategory );

####################

DeclareAttribute( "DgChainComplexCategory", IsCapCategory );
DeclareAttribute( "DgCochainComplexCategory", IsCapCategory );


DeclareGlobalFunction( "ADD_BASIC_FUNCTIONS_TO_DG_COCHAIN_COMPLEX_CATEGORY" );
