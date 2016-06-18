function B = gs(A)

% Gram-Schmidt orthogonalization

% Originator: G.J. Hakim, University of Washington
%
% released under GNU General Public License version 3. http://www.gnu.org/licenses/gpl.html
%
% version control:
% $Date: 2009-02-02 14:42:35 -0800 (Mon, 02 Feb 2009) $
% $Revision: 38 $
% $Author: hakim $
% $Id: gs.m 38 2009-02-02 22:42:35Z hakim $

N = rank(A);

% set and normalize the initial vector
%B(:,1) = A(:,1) / ( A(:,1)' * A(:,1) );
B(:,1) = A(:,1);

for i = 2:N
  u = A(:,i); v = u;
  
  for j = 1:i-1
	 fac = ( (B(:,j)'*u) / ( B(:,j)'*B(:,j) ));
	 v = v - (fac*B(:,j));
  end
  
  B(:,i) = v;
end

% option to normalize
%BN = B'*B;
%for i = 1:N
%  B(:,i) = B(:,i)/(BN(i,i)^0.5);
%end  
