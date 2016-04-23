


f_Left = -10;
f_Right = 10;
f_Bottom = -10;
f_Top = 10;
f_Near = 10;
f_Far = 20;

m_Projection = ...
    [2*f_Near/(f_Right - f_Left), 0, (f_Right + f_Left) / (f_Right - f_Left), 0; ...
     0, 2*f_Near/(f_Top - f_Bottom), (f_Top + f_Bottom) / (f_Top - f_Bottom), 0; ...
     0, 0, -(f_Far + f_Near) / (f_Far - f_Near), -2*(f_Far * f_Near) / (f_Far - f_Near); ...
     0, 0, -1, 0];
     