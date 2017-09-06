% compute mean average precision (MAP)
function [MAP, succRate] = calcMAP (orderH, neighbor)

  [Q, N] = size(neighbor);
  pos = 1: N;
  MAP = 0;
  numSucc = 0;
  for i = 1: Q
    ngb = neighbor(i, orderH(i, :));
    nRel = sum(ngb);
    if nRel > 0
      prec = cumsum(ngb) ./ pos;
      ap = mean(prec(ngb));
      MAP = MAP + ap;
      numSucc = numSucc + 1;
    end
  end
  MAP = MAP / numSucc;
  succRate = numSucc / Q;

end
