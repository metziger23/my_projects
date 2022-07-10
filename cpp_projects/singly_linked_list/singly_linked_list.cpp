// ConsoleApplication1.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <complex>
#include <algorithm>
#include <vector>

using namespace std;

template<typename T>
class List
{
public:
	List();
	~List();

	void push_front(T data);
	void push_back(T data);
	void pop_front();
	void pop_back();
	void insert(T value, int index);
	void remove_at(int index);
	void clear();
	int GetSize() { return Size; };
	T& operator[](const int index);

private:
	template<typename T>
	class Node {
	public:
		Node* pNext;
		T data;
		Node(T data = T(), Node* pNext = nullptr) : data(data), pNext(pNext) {}

	};

	int Size;
	Node<T>* head;
};

template<typename T>
List<T>::List()
{
	Size = 0;
	head = nullptr;
}

template<typename T>
List<T>::~List()
{
	cout << "Destructor has been called" << endl;
	clear();
}

template<typename T>
void List<T>::push_front(T data)
{
	head = new Node<T>(data, head);
	Size++;
}

template<typename T>
void List<T>::push_back(T data)
{
	if (head == nullptr)
	{
		head = new Node<T>(data);
	}
	else
	{
		Node<T>* current = this->head;
		while (current->pNext != nullptr)
		{
			current = current->pNext;
		}
		current->pNext = new Node<T>(data);
	}
	Size++;
}

template<typename T>
void List<T>::pop_front()
{
	Node<T>* temp = head;

	head = head->pNext;

	delete temp;

	Size--;

}

template<typename T>
void List<T>::pop_back()
{
	if (GetSize() == 1) {
		pop_front();
		return;
	}
	Node<T>* previous = head;
	for (int i = 0; i < Size - 1; i++)
	{
		previous = previous->pNext;
	}
	delete previous->pNext;
	previous->pNext = nullptr;
	Size--;

}

template<typename T>
void List<T>::insert(T value, int index)
{
	if (index == 0) {
		push_front(value);
		return;
	}
	else if (index == this->GetSize() - 1) {
		push_back(value);
		return;
	}
	Node<T>* previous = head;
	while (index - 1) {
		previous = previous->pNext;
		index--;
	}
	Node<T>* new_elem = new Node<T>(value, previous->pNext);
	previous->pNext = new_elem;
	Size++;
}

template<typename T>
void List<T>::remove_at(int index)
{
	if (index == 0) {
		pop_front();
		return;
	}
	if (index == Size - 1) {
		pop_back();
		return;
	}
	Node<T>* previous = head;
	for (int i = 0; i < index - 1; i++)
	{
		previous = previous->pNext;
	}
	Node<T>* elem_to_remove = previous->pNext;
	previous->pNext = elem_to_remove->pNext;
	delete elem_to_remove;
	Size--;
}

template<typename T>
void List<T>::clear()
{
	while (Size) {
		pop_front();
	}
}

template<typename T>
T& List<T>::operator[](const int index)
{
	int counter = 0;
	Node<T>* current = this->head;
	while (current != nullptr) {
		if (counter == index) {
			return current->data;
		}
		current = current->pNext;
		counter++;
	}
}

template<typename T>
void show_elements(List<T>& lst) {
	int size = lst.GetSize();
	for (int i = 0; i < size; i++)
	{
		cout << lst[i] << " ";
	}
	cout << endl;
}

int main()
{
	List<int> lst;
	lst.push_back(5);
	lst.push_back(10);
	lst.push_back(22);

	show_elements(lst);

	lst.insert(33, 1);
	lst.insert(11, 0);

	show_elements(lst);

	lst.pop_front();
	lst.pop_front();

	show_elements(lst);

	lst.pop_back();

	lst.pop_back();

	show_elements(lst);

	lst.push_back(50);
	lst.push_back(100);
	lst.push_back(220);

	show_elements(lst);

	lst.remove_at(2);

	show_elements(lst);




	return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
