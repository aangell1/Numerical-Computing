function [alpha, f, grad] = linesch(x, f0, g0, d, c1, c2, fgname);

%  call: [alpha, f, grad] = linesch(x, f0, g0, d, c1, c2, fgname);
%  input
%   x:       intial point
%   f0:      function value at x
%   g0:      directional derivative of function at x in direction d, 
%            gradient*d, (Not gradient)
%   d:       search direction 
%   c1:      Wolfe parameter for the condition 
%            f(x + alpha d) < = f0 + c1*alpha*g0
%   c2:      Wolfe parameter for the condition 
%            abs((grad f)(x + alpha d)'*d) < = -c2*g0
%   fgname:  name of function that returns function, gradient and Hessian
%            it expects as input only x, by [f,g] = feval(fgname, x)
%  output:
%   alpha:    steplength satisfying Wolfe conditions
%   f:        new function value f(x + alpha d)
%   grad:     new gradient value (grad f)(x + alpha d)

if g0 >= 0
   disp('Not a descent direction in line search.'); 
%   alpha = 0; [f,grad] = feval(fgname,x);
%   return; 
end

old = 0; fold = f0;
new = 1;

for k = 1:10
   [fnew,gradnew] = feval(fgname, x + new*d);
   if fnew > f0 + c1*new*g0 | (fnew >= fold)   % gone too far
      [alpha,f,grad] = lszoom(old,new,fold,f0,g0,c1,c2,x,d,fgname);
      return
   end
   gnew = gradnew'*d; % new directional derivative 
   if abs(gnew) <= -c2*g0   % quit, conditions are satisfied first time
      alpha = new; f = fnew; grad = gradnew;
      return; 
   end
   if gnew >= 0     % gone past minimizer, but new point is better than old
      [alpha,f,grad] = lszoom(new,old,fnew,f0,g0,c1,c2,x,d,fgname);
      return; 
   end
   old = new;       % minimizer not bracketed yet
   fold = fnew;
   new = 2*new;     
end % loop
disp('Minimizer was not bracketed in 10 expansion steps')
alpha = new; f = fnew; grad = gradnew; 