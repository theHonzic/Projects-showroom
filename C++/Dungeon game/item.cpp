#include "item.h"

Item::Item(QObject *parent) : QObject(parent)
{

}

Item::Item(std::string name, int healthBonus, int strengthBonus, int position, QString path)
{
    m_name=name;
    m_healthBonus=healthBonus;
    m_strengthBonus=strengthBonus;
    m_position=position;
    m_imagePath=path;
}

int Item::getPosition()
{
    return m_position;
}

std::string Item::getName()
{
    return m_name;
}

void Item::hide()
{
    m_position=100;
}

int Item::getHealthBonus()
{
    std::cout<<"Health increased by "<<m_healthBonus<<std::endl;
    return m_healthBonus;
}

int Item::getStrengthBonus()
{
    std::cout<<"Strength increased by "<<m_strengthBonus<<std::endl;
    return m_strengthBonus;
}

Item *Item::createItem(char symbol, int index)
{
    Item* item;
    switch (symbol) {
    case 'x':
        item=new Item("mec", 0, 20, index, "Images/sword.png");
        break;
    case 'y':
        item=new Item("stit", 20, -3, index, "Images/armor.png");
        break;

    }
    return item;
}

QString Item::getPath()
{
    return m_imagePath;
}
