#include "field.h"

Field::Field(QObject *parent) : QObject(parent)
{

}

Field::Field(std::string type, int position, double damage, QString imagePath)
{
    m_imagePath=imagePath;
    m_type=type;
    m_position=position;
    m_damage=damage;
}


QString Field::getImagePath()
{
//    if(hero!=nullptr){
//    return m_imagePath;
//    }else{
//        return "";
//    }
    return m_imagePath;
}



int Field::getPosition()
{
    return m_position;
}

std::string Field::getType()
{
    return m_type;
}

double Field::getDamage()
{
    return m_damage;
}

void Field::setPosition(int position)
{
    m_position=position;
}

Field *Field::createField(char symbol, int index)
{
    Field* field;
    switch (symbol) {
    case '#':
        field=new Field("lava", index, 30, "Images/lava.png");
        break;
    case '+':
        field=new Field("voda", index, -20, "Images/voda.jpg");
        break;
    case '-':
        field=new Field("zed", index, 0, "Images/wall.jpg");
    }
    return field;
}

void Field::setHero(Hero *hero)
{
    this->hero=hero;
}

void Field::changePath()
{
    m_imagePath="Images/hero.png";
}

void Field::doChange()
{
    emit fieldChanged();
}
