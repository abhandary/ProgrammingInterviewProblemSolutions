
#include <iostream>
#include <vector>
#include <stdexcept>

using namespace std;

class Queue {

public:
  void enqueue(int val);
  int dequeue ();
  bool empty();
  void description ();
  Queue(size_t capacity); 
private:
  static const int kScaleFactor = 2;
  vector<int> _entries;
  int _head, _tail;
};

Queue::Queue(size_t capacity): _entries(capacity), _head(0), _tail(0) 
{

}

void Queue::enqueue (int val) {
  if ((_tail + 1) % _entries.size() == _head) {
      rotate(_entries.begin(), _entries.begin() + _head, _entries.end());
      _entries.resize(_entries.size() * kScaleFactor);
  }

  _entries[_tail] = val;
  _tail = (_tail + 1) % _entries.size();
}

bool Queue::empty () {
   return _entries.size() == 0;
}

int Queue::dequeue () {

   if (_head == _tail) {
     throw length_error("empty queue");
   }

  int val = _entries[_head]; 
  _head = (_head + 1) % _entries.size(); 
  return val;
}

void Queue::description()
{
   int ix = _head;
   std::cout << "======== Circular Queue ========" << std::endl;
   while (ix != _tail)
   {
      std::cout << _entries[ix] << " ";   
      ix = (ix + 1) % _entries.size();
   }
   std::cout << std::endl << "===============================" << std::endl;
}


int main()
{
   Queue cQ(5);

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









