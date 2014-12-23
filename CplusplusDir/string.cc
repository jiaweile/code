#include <string>
#include <iostream>

using namespace std;

void test_string ()
{
	string s = "1234567890";
	char *p  = &s[0];
	cout << *p <<endl;
	for(int i = 0; i < s.length(); i++)
		cout<< s[i] ;
	cout <<endl;
}

int main()
{
	test_string();
}

