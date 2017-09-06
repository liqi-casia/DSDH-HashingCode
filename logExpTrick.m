% avoid floating point overflow when the values in X get too large
function Y = logExpTrick (X)
  Y = X;
  dx = find(X < 100);
  Y(dx) = log(1 + exp(X(dx)));
end
