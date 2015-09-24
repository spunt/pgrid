# PGRID | PMERGE | PSPLIT

PGRID allows easy generation of a grid of UIPANELS in MATLAB for your plotting or GUI building needs. Once you've created a grid, use PMERGE to merge adjacent panels into a single uipanel, and PSPLIT to split a single panel vertically or horizontally.  

## PGRID 

**USAGE**: [phandle, pidx] = pgrid(nrow, ncol, varargin)

#### OUTPUTS

- **hpanel**: array of handles to uipanels comprising the grid
- **hidx**: [row,col] indices for the returned uipanel handles

#### INPUTS

- **nrow**: number of rows in grid
- **ncol**: number of cols in grid

#### VARARGIN

| NAME            | DEFAULT       | DESCRIPTION 
|-----------------|---------------|-----------------------------------------------------
| parent          | gcf           | parent object for grid 
| relwidth        | ones(1, ncol) | relative width of columns (arbitrary units)            
| relheight       | ones(1, nrow) | relative height of rows (arbitrary units)            
| marginsep       | 0.0100        | size of margin surrounding grid (normalized units)           
| panelsep        | 0.0100        | size of space between panels (normalized units)            
| backgroundcolor | [.08 .09 .09] | uipanel background color             
| foregroundcolor | [.97 .97 .97] | uipanel foreground color
| bordertype      | 'none'        | etchedin, etchedout, beveledin, beveledout, line 
| borderwidth     | 1             | uipanel border width in pixels

--

## PMERGE 

Utility for merging cells in a uipanel array created by PGRID

**USAGE**: mhpanel = pmerge(hpanel, grididx)

--

## PSPLIT 

Utility for splitting cells in a uipanel array created by PGRID

**USAGE**: shpanel = psplit(hpanel, grididx, vertical, panelsep)

