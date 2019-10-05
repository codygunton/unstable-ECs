# if I keep doing this, I should refactor code to return gap id's.
# until then, i'll use this if I need it.
order_gap_id_pairs = {2:(2,1), 3:(3,1), 4:(4,1), 6:(6,2), 8:(8,4), 12:(12,1), 24:(24,3)}
def kraus_order_to_gap_id(n):
    return order_gap_id_pairs[n]

# kraus decision tree for Q2 (just coding a table)
# to determine group order (hence group, in this case) just need:
# c invariants, their 2-prime parts, their valuations, their reductions mod 4
# discriminant, its 2-prime part, its valuation, and its reduction mod 4

def kraus_table_Q2(E):
    (c4, c6) = E.c_invariants()
    D  = E.discriminant()

    c4u = c4.prime_to_S_part([2])
    c6u = c6.prime_to_S_part([2])
    Du = D.prime_to_S_part([2])

    vD = valuation(D, 2)
    vc4 = valuation(c4, 2)
    vc6 = valuation(c6, 2)

    c4ured = c4u % 4
    c6ured = c6u % 4
    Dured = Du % 4
    
    bad_tuple = "Bad tuple at curve {}, vD = {}, vc4 = {}, vc6 = {}, c4ured = {}, c6ured = {}, Dured = {}".format(
                                E.cremona_label(), vD, vc4, vc6, c4ured, c6ured, Dured)
    
    if vD == 4:
        if vc4 == 4:
            if c4ured == 3:
                if c6ured == 1:
                    return 3
                else:
                    return 6
            else:
                return 24
        elif vc4 == 5:
            return 24
        elif vc4 > 5:
            if c6ured == 1:
                return 3
            else:
                return 6
        else: 
              raise ValueError(bad_tuple)

    elif vD == 6:
        if vc4 == 4:
            return 8 
        elif vc4 == 5:
            return 8
        elif vc4 > 5:
            return 2
        else:
              raise ValueError(bad_tuple)
              
    elif vD == 7:
        if vc4 == 4:
            return 24
        else:
              raise ValueError(bad_tuple)
    
    elif vD == 8:
        if vc4 == 4:
            if Dured == 3:
                if c6ured == 1:
                    return 6
                else:
                    return 3
            else:
                return 24
        elif vc4 == 5:
            return 24
        elif vc4 == 6:
            return 24
        elif vc4 > 6:
            if c6ured == 1:
                return 3
            else:
                return 6
        else:
              raise ValueError(bad_tuple)
              
    elif vD == 9:
        if vc4 == 4:
            return 8
        elif vc4 == 5:
            if vc6 == 8:
                return 4
            if vc6 > 8:
                return 8
            else:
              raise ValueError(bad_tuple)
        else:
              raise ValueError(bad_tuple)
              
    elif vD == 10:
        if vc4 == 4:
            return 24
        elif vc4 == 5:
              raise ValueError(bad_tuple)
        elif vc4 == 6:
            if c4ured == 3:
                return 6
            else:
                return 24
        elif vc4 == 7:
            return 24
        elif vc4 > 7:        
            return 6
        else:
              raise ValueError(bad_tuple)
            
    elif vD == 11:
        if vc4 == 4:
            return 24
        else:
              raise ValueError(bad_tuple)
           
    elif vD == 12:
        if vc4 == 4:
            return 2
        elif vc4 == 6:
            return 8
        elif vc4 == 7:
            return 8
        elif vc4 == 8:
            return 2
        elif vc4 > 8:
            return 2      
        else:
              raise ValueError(bad_tuple)

    elif vD == 13:
        if vc4 == 6:
            return 24
        else:
              raise ValueError(bad_tuple)

    elif vD == 14:
        if vc4 == 6:
            if Dured == 3:
                return 6
            else:
                return 24
        elif vc4 == 7:
            return 24
        elif vc4 == 8:
            return 24
        elif vc4 > 8:
            return 6
        else:
              raise ValueError(bad_tuple)

    elif vD == 15:
        if vc4 == 6:
            return 8
        if vc4 == 7:
            if vc6 == 11:
                return 4
            else:
                return 8
        else:
              raise ValueError(bad_tuple)
            
    elif vD == 16:
        if vc4 == 6:
            return 24
        else:
              raise ValueError(bad_tuple)

    elif vD == 17:
        if vc4 == 6:
            return 24
        else:
              raise ValueError(bad_tuple)

    elif vD == 18:
        if vc4 == 6:
            return 2
        else:
              raise ValueError(bad_tuple)
             
    else:
          raise ValueError(bad_tuple)


##############################################################
##############################################################

# kraus decision tree for Q3 (just coding a table)
# to determine group order (hence group, in this case) just need:
# c invariants, their valuations, discriminant, its valuation,
# and in two cases you can count solutions too a certain polynomial 
# or compute the Kodaira symbol (I do this).

def kraus_table_Q3(E):
    (c4, c6) = E.c_invariants()
    D  = E.discriminant()
    vD = valuation(D, 3)
    vc6 = valuation(c6, 3)
    
    bad_pair = "Bad tuple at curve {}, vD = {}, vc6 = {}".format(E.cremona_label(), vD, vc6)
    
    if vD == 3:
        if vc6 == 3:
            if E.kodaira_symbol(3) == KodairaSymbol("III"):
                return 4
            else:
                return 12
        if vc6 == 4:
            return 12
        if vc6 > 4:
            return 4
        else:
            raise ValueError(bad_pair)
    
    if vD == 4: 
        if vc6 == 3:
            return 3
        else:
            raise ValueError(bad_pair)

    if vD == 5:
        if vc6 == 3 or vc6 == 4:
            return 12
        else:
            raise ValueError(bad_pair)

    if vD == 6:
        if vc6 == 3:
            return 2
        if vc6 == 5:
            return 6
        if vc6 > 5:
            return 2        
        else:
            raise ValueError(bad_pair)

    if vD == 7:
        if vc6 == 5:
            return 12
        else:
            raise ValueError(bad_pair)

    if vD == 9:
        if vc6 == 6:
            if E.kodaira_symbol(3) == KodairaSymbol("III*"):
                return 4
            else:
                return 12
        if vc6 == 7:
            return 12
        if vc6 > 7:
            return 4        
        else:
            raise ValueError(bad_pair)

    if vD == 10:
        if vc6 == 6:
            return 6
        else:
            raise ValueError(bad_pair)
            
    if vD == 11:
        if vc6 == 6 or vc6 == 7:
            return 12
        else:
            raise ValueError(bad_pair)
            
    if vD == 12:
        if vc6 == 8:
            return 3
        else:
            raise ValueError(bad_pair)

    if vD == 13:
        if vc6 == 8:
            return 12
        else:
            raise ValueError(bad_pair)
                        
    else:
        raise ValueError("Invalid vD equal to {}".format(vD))