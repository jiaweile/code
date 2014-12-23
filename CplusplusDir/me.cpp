#include <iostream>

extern "C" {

class A{
	public: int m;
	private: int n;
};
}

int main()
{
	A a;
	a.m = 4;
	printf("a.m is: %d\n", a.m);
	printf("extern C for class done\n");
	exit(0);

}
