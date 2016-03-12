#ifndef _CUBIC
#define _CUBIC
class CachedBicubicInterpolator{

	private:
	double a00, a01, a02, a03;
	double a10, a11, a12, a13;
	double a20, a21, a22, a23;
	double a30, a31, a32, a33;

	public:
	void updateCoefficients (double  p[4][4]);
	double getValue (double x, double y);
};
#endif
