#include "map.h"
#include <fstream>
#include <QList>
#include <QRandomGenerator>
#include <QVariant>
#include <QVariantList>
#include <random>
#include "field.h"


Map::Map(QObject *parent) : QObject(parent)
{

}



void Map::load(std::string file)
{

    std::ifstream input;
    std::string line;
    input.open(file);
    if(input.is_open()){
        int index=0;
        std::cout<<"File is opened"<<std::endl;
        while(getline(input, line)){
            for (auto symbol: line){
                    if(symbol=='#' or symbol=='-' or symbol=='+'){
                        Field* field = Field::createField(symbol, index);
                        m_map.push_back(field);
                        std::cout<<"nacitam pole "<<index<<" s texturou "<<field->getType()<<std::endl;
                        index++;
                    }else if(symbol=='x' or symbol=='y'){
                        Item* item = Item::createItem(symbol, index);
                        m_items.push_back(item);
                        std::cout<<"nacitam item na poli "<<index<<" predmet: "<<item->getName()<<std::endl;
                    }else if(symbol=='e' or symbol=='f' or symbol=='q'){
                        Enemy* enemy = Enemy::createEnemy(symbol,index);
                        m_enemies.push_back(enemy);
                        std::cout<<"nacitam enemy na poli "<<index<<" se jmenem "<<enemy->getName()<<std::endl;
                    }
            }


        }
    }else{
        std::cout<<"file cannot be opened"<<std::endl;
    }
}

QString Map::getType(int index)
{
    std::string type=m_map.at(index)->getType();
    return QString::fromStdString(type);
}

Map::Map(std::string file)
{
    std::cout<<"vytvarim instanci map"<<std::endl;
    load(file);
    m_hero=new Hero("Aleix", 80, 80);

}

QVariant Map::getData()
{
    return QVariant::fromValue(m_map);
}

QString Map::getImagePath(int index)
{
    return m_map.at(index)->getImagePath();
}



void Map::doChange()
{

////    // randomly mix up the array
//    std::random_device rd;
//    std::mt19937 rng(rd());
//    std::shuffle(m_map.begin(), m_map.end(), rng);

//    std::cout<<"do change"<<std::endl;

    // tell UI that data has changed
    emit dataChanged();
}

QString Map::getHero(int index)
{
    if(m_map.at(index)->getPosition() == m_hero->getPosition()){
        return m_hero->getPath();
    }else{
        return "";
    }
}

QString Map::getItem(int index)
{
    QString path="";
    for(auto item : m_items){
        if(item->getPosition() == m_map.at(index)->getPosition()){
            path = item->getPath();
        }
    }
    return path;
}

QString Map::getEnemy(int index)
{
    QString path="";
    for(auto enemy : m_enemies){
        if(enemy->getPosition() == m_map.at(index)->getPosition()){
            path = enemy->getImagePath();
        }
    }
    return path;
}

void Map::setHeroPosition(int index)
{
    m_hero->setPosition(index);
}

void Map::moveLeft()
{
    if(m_hero->getPosition()%10==0){
        std::cout<<"cannot move left"<<std::endl;

    }else {
        m_hero->move(-1);
        std::cout<<"Moved left, new position="<<m_hero->getPosition()<<std::endl;
        for (auto item: m_items){
            if(item->getPosition()==m_hero->getPosition()){
                m_hero->pick(item);
            }

        }
    dataChanged();
}

}

void Map::moveUp()
{
    if (m_hero->getPosition()<=9 && m_hero->getPosition()>=0){
        std::cout<<"cannot move up"<<std::endl;
    }else{
    m_hero->move(-10);
    std::cout<<"Moved up, new position="<<m_hero->getPosition()<<std::endl;
    for (auto item: m_items){
        if(item->getPosition()==m_hero->getPosition()){
            m_hero->pick(item);
        }
    }

    }

}

void Map::moveDown()
{
    if (m_hero->getPosition()<=99 && m_hero->getPosition()>=90){
        std::cout<<"cannot move down"<<std::endl;
    }else{
        m_hero->move(10);
        std::cout<<"Moved down, new position="<<m_hero->getPosition()<<std::endl;
        for (auto item: m_items){
            if(item->getPosition()==m_hero->getPosition()){
                m_hero->pick(item);
            }
        }

    }


}

void Map::moveRight()
{
    if(m_hero->getPosition()%10==9){
        std::cout<<"cannot move right"<<std::endl;

    }else {
        m_hero->move(1);
        std::cout<<"Moved right, new position="<<m_hero->getPosition()<<std::endl;
        for (auto item: m_items){
            if(item->getPosition()==m_hero->getPosition()){
                m_hero->pick(item);
            }
        }

    }
}

void Map::addHero(int index)
{
    m_map.at(index)->setHero(m_hero);
}




