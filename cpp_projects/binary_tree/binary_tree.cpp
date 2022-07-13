#include <iostream>
#include <complex>
#include <algorithm>
#include <vector>


using namespace std;

template<typename T>
class Set
{
public:
	Set();
	~Set();


private:
	template<typename T>
	class Node {
	public:
		Node* pLeft;
		Node* pRight;
		T data;
		Node(T data = T(), Node* pLeft = nullptr, Node* pRight = nullptr) :
			data(data),
			pLeft(pLeft),
			pRight(pRight) {}
	};

	int Size;
	Node<T>* root;

	enum Direction
	{
		None,
		Left,
		Right
	};

public:
	bool insert(T value);
	void show_elements();
	bool check_if_exists(T value);
	void clear(Node<T>* root_arg);
	int get_size();
	void remove_element(T value);
private:
	void show_elements(Node<T>* root_arg, int level);
	bool insert(T value, Node<T>* root_arg);
	bool check_if_exists(T value, Node<T>* root_arg);
	void remove_element(T value, Node<T>* current, Node<T>* parent, Direction direction);
	Node<T>* find_min(Node<T>* root_arg) {
		if (root_arg->pLeft == nullptr) {
			return root_arg;
		}
		find_min(root_arg->pLeft);
	}

};

template<typename T>
Set<T>::Set() : root(nullptr), Size(0) {}


template<typename T>
Set<T>::~Set()
{
	clear(root);
}

template<typename T>
bool Set<T>::insert(T value)
{
	bool added = insert(value, root);
	if (added) Size++;
	return added;
}

template<typename T>
bool Set<T>::insert(T value, Node<T>* root_arg)
{
	if (root == nullptr) {
		root = new Node<T>(value);
		return true;
	}
	else if (value < root_arg->data && root_arg->pLeft == nullptr) {
		root_arg->pLeft = new Node<T>(value);
		return true;
	}
	else if (value > root_arg->data && root_arg->pRight == nullptr) {
		root_arg->pRight = new Node<T>(value);
		return true;
	}
	else if (value < root_arg->data && root_arg->pLeft) {
		return Set<T>::insert(value, root_arg->pLeft);
	}
	else if (value > root_arg->data && root_arg->pRight) {
		return Set<T>::insert(value, root_arg->pRight);
	}
	else return false;
}

template<typename T>
void Set<T>::show_elements()
{
	show_elements(root, 0);
}

template<typename T>
bool Set<T>::check_if_exists(T value)
{
	return check_if_exists(value, root);
}

template<typename T>
bool Set<T>::check_if_exists(T value, Node<T>* root_arg)
{
	if (root_arg->data == value) return true;
	else if (value < root_arg->data && root_arg->pLeft) check_if_exists(value, root_arg->pLeft);
	else if (value > root_arg->data && root_arg->pRight) check_if_exists(value, root_arg->pRight);
	else return false;
}

template<typename T>
void Set<T>::remove_element(T value)
{
	remove_element(value, root, nullptr, Direction::None);
}

template<typename T>
void Set<T>::remove_element(T value, Node<T>* current, Node<T>* parent, Direction direction)
{
	if (current == nullptr) return;
	// case 1: Node has no child
	if (current->data == value) {
		if (current->pLeft == nullptr && current->pRight == nullptr) {
			cout << value << "\t" << "has been deleted in remove_element" << endl;
			delete current;
			if (direction == Direction::Left) parent->pLeft = nullptr;
			if (direction == Direction::Right) parent->pRight = nullptr;
			Size--;
			return;
		}
		// case 2: Node has one child
		if (current->pLeft && current->pRight == nullptr) {
			current->data = current->pLeft->data;
			current->pLeft->data = value;
			remove_element(value, current->pLeft, current, Direction::Left);
		}
		if (current->pLeft == nullptr && current->pRight) {
			current->data = current->pRight->data;
			current->pRight->data = value;
			remove_element(value, current->pRight, current, Direction::Right);
		}
		// case 3: Node has two children
		if (current->pRight) {
			Node<T>* elem_to_swap = find_min(current->pRight);
			current->data = elem_to_swap->data;
			elem_to_swap->data = value;
			remove_element(value, current->pRight, current, Direction::Right);
		}
	}

	if (value < current->data && current->pLeft) remove_element(value, current->pLeft, current, Direction::Left);
	if (value > current->data && current->pRight) remove_element(value, current->pRight, current, Direction::Right);

}

template<typename T>
void Set<T>::clear(Node<T>* root_arg)
{
	if (root_arg->pLeft) {
		clear(root_arg->pLeft);
	}
	if (root_arg->pRight) {
		clear(root_arg->pRight);
	}
	else if (root_arg->pLeft == nullptr && root_arg->pRight == nullptr) {
		cout << root_arg->data << "\thas been deleted" << endl;
		delete root_arg;
		Size--;
		return;
	}
	cout << root_arg->data << "\thas been deleted" << endl;
	delete root_arg;
	Size--;

}

template<typename T>
int Set<T>::get_size()
{
	return Size;
}

template<typename T>
void Set<T>::show_elements(Node<T>* root_arg, int level)
{
	if (root_arg == nullptr)
		return;
	cout << "level:" << level << "\t\tdata:" << root_arg->data << endl;
	show_elements(root_arg->pLeft, level + 1);
	show_elements(root_arg->pRight, level + 1);
}

int main()
{
	Set<int> my_set;
	my_set.insert(5);
	my_set.insert(12);
	my_set.insert(7);
	my_set.insert(10);
	my_set.insert(14);
	my_set.insert(13);

	cout << my_set.insert(3) << endl;
	cout << my_set.insert(3) << endl;
	my_set.show_elements();
	cout << "Current size: " << my_set.get_size() << endl;

	cout << "Does " << 5 << " exist in the set: " << my_set.check_if_exists(5) << endl;
	cout << "Does " << 12 << " exist in the set: " << my_set.check_if_exists(12) << endl;
	cout << "Does " << 10 << " exist in the set: " << my_set.check_if_exists(10) << endl;
	cout << "Does " << 9 << " exist in the set: " << my_set.check_if_exists(9) << endl;
	cout << "Does " << 11 << " exist in the set: " << my_set.check_if_exists(11) << endl;

	cout << "######" << endl;
	//my_set.remove_element(3);	//removal of a no-child node
	//my_set.remove_element(7);	//removal of a one-child node
	my_set.remove_element(12);	//removal of a two-child node

	my_set.show_elements();
	cout << "Current size: " << my_set.get_size() << endl;



	return 0;
}

