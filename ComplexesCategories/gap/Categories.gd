# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#
#! @Chapter Complexes categories
##
#############################################################################

if not IsBound( Reasons ) then 
    DeclareGlobalVariable( "Reasons" );
    InstallValue( Reasons, [ fail ] );
    DeclareGlobalVariable( "AddToReasons" );
    DeclareGlobalVariable( "why" );
    InstallValue( AddToReasons, function( s )
                                Add( Reasons, s, 1 ); 
                                MakeReadWriteGlobal("why");
                                why := s;
                                MakeReadOnlyGlobal("why");
                                end );
fi;

InfoComplexesCategories := NewInfoClass( "InfoComplexesCategories" );

SetInfoLevel( InfoComplexesCategories, 1 );

#! @Section Constructing chain and cochain categories


###################################################
#
# (Co)chain complexes categories filters
#
###################################################

#! @Description
#!  Gap-categories of the chain or cochain complexes category.
DeclareCategory( "IsChainOrCochainComplexCategory", IsCapCategory );

#! @Description
#!  Gap-categories of the chain or cochain complexes category.
DeclareCategory( "IsBoundedChainOrCochainComplexCategory", IsChainOrCochainComplexCategory );

#! @Description
#!  Gap-categories of the chain complexes category.
DeclareCategory( "IsChainComplexCategory", IsChainOrCochainComplexCategory );

#! @Description
#!  Gap-categories of the chain complexes category.
DeclareCategory( "IsBoundedChainComplexCategory", IsBoundedChainOrCochainComplexCategory );

#! @Description
#!  Gap-category of the cochain complexes category.
DeclareCategory( "IsCochainComplexCategory", IsChainOrCochainComplexCategory );

#! @Description
#!  Gap-category of the cochain complexes category.
DeclareCategory( "IsBoundedCochainComplexCategory", IsBoundedChainOrCochainComplexCategory );

###################################################
#
#  Constructors of (Co)chain complexes categories
#
###################################################

#! @Description
#!  Creates the chain complex category $\mathrm{Ch}_\bullet(A)$ an additive category $A$. If you want to contruct the category without finalizing it so that you can add
#! your own methods, you can run the command $\texttt{ChainComplexCategory(A : FinalizeCategory := false )}$. 
#! @Arguments A
#! @Returns a CAP category
DeclareAttribute( "ChainComplexCategory", IsCapCategory );

DeclareAttribute( "ComplexCategoryByChains", IsCapCategory );

#! @Description
#!  Creates the cochain complex category $\mathrm{Ch}^\bullet(A)$ an additive category $A$. If you want to contruct the category without finalizing it so that you can add
#! your own methods, you can run the command $\texttt{CochainComplexCategory(A : FinalizeCategory := false )}$.
#! @Arguments A
#! @Returns a CAP category
DeclareAttribute( "CochainComplexCategory", IsCapCategory );

DeclareAttribute( "ComplexCategoryByCochains", IsCapCategory );

#! @Description
#! The input is a chain or cochain complex category $B=C(A)$ constructed by one of the previous commands. 
#! The outout is $A$
#! @Arguments B
#! @Returns a CAP category
DeclareAttribute( "UnderlyingCategory", IsChainOrCochainComplexCategory );

#! @Description
#! The input is a chain or cochain complex category $B=C(A)$ and an integer $n$. 
#! The outout is the additive full subcategory generated by complexes concentrated in degree $n$.
#! @Arguments B, n
#! @Returns a CAP category
KeyDependentOperation( "FullSubcategoryGeneratedByComplexesConcentratedInDegree",
    IsChainOrCochainComplexCategory, IsInt, ReturnTrue
);

DeclareOperation( "\/", [ IsCapCategoryObject, IsChainOrCochainComplexCategory ] );
DeclareOperation( "\/", [ IsCapCategoryMorphism, IsChainOrCochainComplexCategory ] );

#! @Section Examples
#? @InsertChunk vec_0

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_CHAIN_COMPLEXES" );

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_CHAIN_MORPHISMS" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_CHAIN_COMPLEXES" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_CHAIN_MORPHISMS" );

DeclareGlobalFunction( "ADD_TENSOR_UNIT_CHAIN" );

DeclareGlobalFunction( "ADD_BRAIDING_FOR_CHAINS" );

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_TO_INTERNAL_HOM_ADJUNCTION_MAP" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_TO_TENSOR_PRODUCT_ADJUNCTION_MAP" );
