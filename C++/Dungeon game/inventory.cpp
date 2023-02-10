#include "inventory.h"

Inventory::Inventory(QObject *parent) : QObject(parent)
{
    for(auto item:m_items){
        item=nullptr;
    }
}

void Inventory::addItem(Item *item)
{
    m_items.push_back(item);
}

void Inventory::removeItem(int which)
{
    m_items.removeAt(which);
}

int Inventory::getSize()
{
    return m_items.size();
}


