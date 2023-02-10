#include "hero.h"

Hero::Hero(QObject *parent) : QObject(parent)
{

}

Hero::Hero(std::string name, int health, int strength)
{
    m_name=QString::fromStdString(name);
    m_health=health;
    m_position=3;
    m_strength=strength;
    std::cout<<"Hero added at "<<m_position<<" position"<<std::endl;
    m_inventory=new Inventory();
    m_canCarry=true;
}

void Hero::getBonus(Item *item)
{
    m_health+=item->getHealthBonus();
    m_strength+=item->getStrengthBonus();
}

void Hero::checkInventoryStatus()
{
    if(m_inventory->getSize()>=6){
        changeCarry(false);
    }else {
        changeCarry(true);
    }
}

QString Hero::getPath()
{
    return m_imagePath;
}

void Hero::changeCarry(bool state)
{
    m_canCarry=state;
}

int Hero::getPosition()
{
    return m_position;
}

void Hero::setPosition(int position)
{
    m_position=position;
    std::cout<<"Position changed on "<<position<<std::endl;
}

void Hero::move(int oKolik)
{
    setPosition(getPosition()+oKolik);

}

void Hero::pick(Item *item)
{
    if (m_canCarry){
    int previousHealth=m_health;
    int previousStrength=m_strength;
    m_inventory->addItem(item);
    std::cout<<"picked "<<item->getName()<<std::endl;
    getBonus(item);
    std::cout<<"Health increased from "<<previousHealth<<" to "<<m_health<<std::endl;
    std::cout<<"Strength increased from "<<previousStrength<<" to "<<m_strength<<std::endl;
    item->hide();

    }else{
        std::cout<<"you cannot carry that"<<std::endl;
    }
    checkInventoryStatus();
}
