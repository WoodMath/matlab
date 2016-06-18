function [fY] = fnEpiLineY(fX,v3_line)

	fY = (v3_line(1)*fX+v3_line(3))/-v3_line(2);

end
