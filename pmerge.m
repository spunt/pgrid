function mhpanel = pmerge(hpanel, grididx)

    if nargin < 2, error('USAGE: [mhgrid, mgrididx] = pmerge(hgrid, grididx)'); end
    p       = hpanel(grididx);
    ptag    = get(p, 'Tag');


    % | GET DIMENSIONS 
    hpos    = cell2mat(get(hpanel, 'pos'));
    ppos    = cell2mat(get(p, 'pos'));
    ncell   = length(grididx); 
    nrow    = length(unique(ppos(:,2)));
    ncol    = length(unique(ppos(:,1)));

    % | CHECK VALIDITY
    if all([nrow>1, ncol>1, mod(ncell, 2)]), error('Invalid grid indices!'); end
    rowidx  = find(ismember(hpos(:,2), ppos(:,2)));
    colidx  = find(ismember(hpos(:,1), ppos(:,1)));
    if any(diff(rowidx)>1), error('Invalid row indices!'); end
    if any(diff(colidx)>1), error('Invalid column indices'); end
    
    % | COMPUTE WIDTH AND HEIGHT OF MERGED PANEL
    pleft   = unique(ppos(:,1));
    pright  = unique(sum(ppos(:,[1 3]), 2));
    pbottom = unique(ppos(:,2)); 
    ptop    = unique(sum(ppos(:,[2 4]), 2)); 
    w       = max(pright) - min(pleft);
    h       = max(ptop) - min(pbottom); 
    
    % | DELETE OLD, CREATE NEW
    pidx    = regexpi(ptag, 'x', 'split');
    ptagidx = cell2num(vertcat(pidx{:}));
    urowtag = unique(ptagidx(:,1));
    ucoltag = unique(ptagidx(:,2)); 
    if nrow > 1
        rowtag = sprintf('%d:%d', urowtag);
    else
        rowtag = sprintf('%d', urowtag); 
    end
    if ncol > 1
        coltag = sprintf('%d:%d', ucoltag); 
    else
        coltag = sprintf('%d', ucoltag); 
    end
    mtag = sprintf('[%s]x[%s]', rowtag, coltag); 
    mhgrid  = p(1);
    delete(p(2:end));
    mpos    = [min(ppos(:,1:2)) w h];
    set(mhgrid, 'position', mpos, 'tag', mtag);
    drawnow; 
    mhpanel = hpanel;
    mhpanel(grididx(2:end)) = [];

end
function out = cell2num(in)
% CELL2NUM Convert cell array of strings naming numbers, or a 
% cell array of numbers, to a numeric array, with empty cells replaced
% with NaN
%
%       USAGE: out = cell2num(in)
%           
% -------------------------------------------------------------------
if nargin<1, error('USAGE: out = cell2num(in)'); end
if ischar(in), in = cellstr(in); end
out = in;
if ischar(in{1})
    out = strtrim(out);
    out(cellfun('isempty', out)) = {'NaN'};
    out = cellfun(@str2num, out, 'Uni', false);
    out = cell2mat(out);
elseif isnumeric(in{1})
    out(cellfun('isempty', out)) = {NaN};
    out = cell2mat(out);
end
end