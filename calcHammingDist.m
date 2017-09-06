% compute the hamming distance between every pair of data points represented in each row of B1 and B2
function D = calcHammingDist (B1, B2)
  P1 = sign(B1 - 0.5);
  P2 = sign(B2 - 0.5);

  R = size(P1, 2);
  D = round((R - P1 * P2') / 2);

end
