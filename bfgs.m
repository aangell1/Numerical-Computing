function [x,f,grad,steps,xvec]=bfgs(x0,c1,c2,fgname,linesearch)
% call [x,f,grad,steps,xvec]=bfgs(x0,c1,c2,fgname,linesearch)
%  input
%   x0:      initial guess
%   c1:      Wolfe parameter for the condition 
%            f(x + alpha d) < = f0 + c1*alpha*g0
%   c2:      Wolfe parameter for the condition 
%            abs((grad f)(x + alpha d)'*d) < = -c2*g0
%   fgname:  name of function that returns function, gradient and Hessian
%            it expects as input only x, by [f,g] = feval(fgname, x)
%  output:
%   x:       returned minimum
%   f:       function value at x
%   grad:    gradient value at x
%   steps:   number of iteraions
 
x = x0; 
xvec=[x0];

H = eye(size(x0,1));
for k=1:100
    steps = k; 
    [f,grad]=feval(fgname,x);
    if norm(grad,2) < 1.e-6
        return; 
    end      
    d = - H*grad;
    g = grad'*d;

    if (linesearch == 1) 
        [alpha,fnew,gradnew] = linesch(x,f,g,d,c1,c2,fgname);
        xnew = x + alpha*d;
    else
        alpha = 1.0; 
        xnew = x + d;
        [fnew,gradnew] = feval(fgname,xnew);
    end
    
    if (mod(k,3) == 1)
        xvec = [xvec xnew];
    end
    
    % Update inverse Hessian matrix.
    s = xnew - x;
    y = gradnew - grad;
    rho = 1.0/(y'*s);
    H = H - rho*(H*y)*s' - rho*s*( (y'*(H-rho*(H*y)*s')) - s' );
  
    x = xnew; 
end  
disp('No convergence in 100 BFGS iterations');