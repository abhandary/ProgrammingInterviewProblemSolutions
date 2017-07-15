
#include <iostream>
#include <deque>
#include <stdexcept>

using namespace std;

class SQueue
{
public: 
  void enqueue(int val);
  int dequeue();
  void description(); 
private:
  deque<int> _enq, _deq; 
};


void SQueue::enqueue (int val) {
    _enq.push_back(val);  
}

int SQueue::dequeue()
{
   while(!_enq.empty()) {
     _deq.push_back(_enq.front());
     _enq.pop_front();
   }

   if (_deq.size() == 0)
     throw length_error("empty queue");
 
   int val = _deq.front(); 
   _deq.pop_front();
   return val;
}

void SQueue::description()
{
  std::cout << "========= Stacky Queue ===========" << std::endl;
  for(int val : _enq) {
    std::cout << val << " ";
  } 
  for(int val : _deq) {
    std::cout << val << " ";
  } 
  std::cout << std::endl << "==============================" << std::endl;
}

int main()
{
   SQueue cQ;

   cQ.enqueue(10);
   cQ.description();
   cQ.enqueue(12);
   cQ.description();
   cQ.enqueue(13);
   cQ.description();
   cQ.enqueue(14);
   cQ.description();
   cQ.enqueue(15);
   cQ.description();
   cQ.enqueue(16);
   cQ.description();
   cQ.dequeue();
   cQ.description();
   cQ.dequeue();
   cQ.description();
   cQ.dequeue();
   cQ.description();
   cQ.dequeue();
   cQ.description();
   cQ.dequeue();
   cQ.description();
   cQ.dequeue();
   cQ.description();
   cQ.dequeue();

   return 0;


}



