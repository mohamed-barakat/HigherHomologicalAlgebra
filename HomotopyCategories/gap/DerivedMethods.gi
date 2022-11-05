# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
##
InstallMethod( MorphismToColiftingObject,
          [ IsChainOrCochainComplexCategory, IsChainOrCochainComplex ],
          
  function( cat, a )
    
    return NaturalInjectionInMappingCone( IdentityMorphism( a ) );
    
end );

##
InstallMethod( IsColiftableAlongMorphismToColiftingObject,
          [ IsChainOrCochainComplexCategory, IsChainOrCochainMorphism ],
          
  function( cat, alpha )
    local a, I_a;
    
    a := Source( alpha );
    
    I_a := NaturalInjectionInMappingCone( IdentityMorphism( a ) );
    
    return IsColiftable( I_a, alpha );
    
end );

##
InstallMethod( IsColiftableAlongMorphismToColiftingObject,
          [ IsChainOrCochainComplexCategory, IsChainOrCochainMorphism ],
          
  { cat, alpha } -> IsNullHomotopic( alpha )
);

