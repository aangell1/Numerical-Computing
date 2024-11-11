function [alpha,f,grad] = lszoom(lo,hi,flo,f0,g0,c1,c2,x,d,fgname)

%  intended only to be called by linesch.m
 
for k = 1:50   % loop until the return is executed, hopefully 50 is enough
  am = (lo + hi)/2;
  [fm,gradm] = feval(fgname, x + am*d);
  gm=gradm'*d;

  if fm > f0 + c1*am*g0 | fm >= flo    % gone too far
      hi = am;
  else
      if abs(gm) <= -c2*g0     % strong Wolfe conditions are satisfied
         alpha = am; f = fm; grad = gradm;
         return; 
      end
      if gm*(hi - lo) >= 0     % check which way to look next
         hi = lo;
      end
      lo = am;
      flo = fm;                
  end
end 
disp('More than 50 steps needed in Zoom')
alpha = lo; f = flo; grad = gradm;