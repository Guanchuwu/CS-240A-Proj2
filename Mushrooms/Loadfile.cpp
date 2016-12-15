#include <fstream>
#include <string>
#include <vector>
#include <sstream>
#include <iterator>
#include <stdlib.h>
using namespace std;
class Loadfile{
	public:
 	void load(string fileName){
 		ifstream fin (fileName);
 		ofstream fout ("Dataset.deal");
 		string line;
 		int train=1;
 		int test=1;
 		while (getline (fin,line,'\n')){
 			stringstream ss(line);
 			istream_iterator<string> begin(ss);
    		istream_iterator<string> end;
			vector<string> v(begin, end);
			int size = v.size();
			//random partation data into training and testing sets
			if (rand()%100<75){
				for (int i=0;i<size;i++){
				if (i>0)
				fout<<"patterns("+to_string(train)+','+to_string(i)+','+'\''+v[i]+'\''+")."<<'\n';
				else 
				fout<<"labels("+to_string(train)+','+'\''+v[i]+'\''+")."<<'\n';
			}
			train++;
			}

			else {
				for (int i=0;i<size;i++){
				if (i>0)
				fout<<"test_data("+to_string(test)+','+to_string(i)+','+'\''+v[i]+'\''+")."<<'\n';
				else 
				fout<<"test_labels("+to_string(test)+','+'\''+v[i]+'\''+")."<<'\n';
			}
			test++;
			}
			
			
 		}
 		fin.close();
 		fout.close();
 	}
};

int main(){
	Loadfile A;
	A.load("Dataset.data");
}