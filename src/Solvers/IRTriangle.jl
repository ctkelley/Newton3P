"""
IRTriangle!(AF::MPFact, r, rs, verbose)

Solve for the defect by demoting the residual and quering on_the_fly
to figure out if we can do the triangular solves entirely in low precision.

The solve overwrites the residual with the defect.
"""
function IRTriangle!(AF::MPFact, r, rs, verbose)
    AFS = AF.AF
    if on_the_fly(AF)
        ldiv!(AFS, r)
    else
        TFact = eltype(AFS)
        TH = eltype(r)
        rs .= TFact.(r)
        ldiv!(AFS, rs)
        r .= TH.(rs)
    end
    return r
end
