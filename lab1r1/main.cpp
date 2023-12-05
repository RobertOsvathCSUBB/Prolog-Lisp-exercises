/*
    a. Substitute

    substitute(list([H|T]), position, new value) =
    {
        H = new value, if position = 0;
        [], if the list is empty;
        T = substitute(T, position - 1, new value), otherwise
    }
    ->substitute(input, input, input)

    b. Difference

    difference(listA[H|T], listB) = 
    {
        [], if listA is empty
        T = [HT|TR] -> H=HT, otherwise
    }

*/

#include <iostream>

#define NULL_ELEM -999999

struct Node
{
    int value;
    Node* next;
};

Node* substitute(Node* head, int i, int newValue)
{
    if (head->value == NULL_ELEM)
        return head;
    if (i == 0)
    {
        head->value = newValue;
        return head;
    }
    substitute(head->next, i - 1, newValue);
}

bool contains(Node* head, int val)
{
    if (head->value == NULL_ELEM)
        return false;
    if (head->value == val)
        return true;
    return contains(head->next, val);
}

Node* difference(Node* headA, Node* headB, Node* previous)
{
    if (headA->value == NULL_ELEM)
        return headA;
    if (contains(headB, headA->value))
    {
        if (previous != nullptr)
        {
            previous->next = headA->next;
        }
        else
        {
            headA->value = NULL_ELEM;
        }
    }
    difference(headA->next, headB, headA);
}

int main()
{
    Node* head = new Node;
    head->value = NULL_ELEM;
    head->next = nullptr;
    int x;
    Node* current = nullptr;
    int length;
    std::cout << "Enter the length of the list: ";
    std::cin >> length;
    std::cout << "Enter a list of numbers: ";
    for (int i = 0; i < length; i++)
    {
        std::cin >> x;
        if (head->value == NULL_ELEM)
        {
            head->value = x;
            current = new Node;
            current->value = NULL_ELEM;
            current->next = nullptr;
            head->next = current;
        }
        else
        {
            current->value = x;
            current->next = new Node;
            current->next->value = NULL_ELEM;
            current = current->next;
        }
    }

    std::cout << "Enter the position to be substituted: ";
    int pos;
    std::cin >> pos;
    pos--;

    std::cout << "Enter the value to be substituted with: ";
    int val;
    std::cin >> val;

    Node* retNode = substitute(head, pos, val);
    std::cout << "The list is: \n";

    current = head;
    while (current->value != NULL_ELEM)
    {
        std::cout << current->value << " ";
        current = current->next;
    }
    std::cout << std::endl;

    int p = 2;
    Node* head2 = new Node;
    head2->value = NULL_ELEM;
    head2->next = nullptr;
    Node* current2 = nullptr;
    for (int i = 0; i < 5; i++)
    {
        if (i == 0)
        {
            head2->value = p;
            current2 = new Node;
            current2->value = NULL_ELEM;
            current2->next = nullptr;
            head2->next = current2;
        }
        else
        {
            current2->value = p;
            current2->next = new Node;
            current2->next->value = NULL_ELEM;
            current2 = current2->next;
        }
        p += 2;
    }

    Node* ret = difference(head, head2, nullptr);
    std::cout << "The difference with the list 2 4 6 8 is: \n";
    if (head->value == NULL_ELEM)
        head = head->next;
    while (head->value != NULL_ELEM)
    {
        std::cout << head->value << " ";
        head = head->next;
    }

    return 0;
}