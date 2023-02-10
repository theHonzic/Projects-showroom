#ifndef MAP_H
#define MAP_H

#include <QObject>
#include "field.h"
#include <iostream>
#include <QList>
#include <QVariant>
#include <QObjectList>
#include "enemy.h"

class Map : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant m_map READ getData NOTIFY dataChanged)
public:
    explicit Map(QObject *parent = nullptr);
    Q_INVOKABLE QString getType(int index);
    Map(std::string file);
    Q_INVOKABLE QVariant getData();
    Q_INVOKABLE QString getImagePath(int index);
    Q_INVOKABLE void doChange();
    Q_INVOKABLE QString getHero(int index);
    Q_INVOKABLE QString getItem(int index);
    Q_INVOKABLE QString getEnemy(int index);
    Q_INVOKABLE void setHeroPosition(int index);
    Q_INVOKABLE void moveLeft();
    Q_INVOKABLE void moveUp();
    Q_INVOKABLE void moveDown();
    Q_INVOKABLE void moveRight();

    Hero* m_hero;
    void addHero(int index);
    void removeHero(int index);
    std::vector<Item*>m_items;
    std::vector<Enemy*>m_enemies;
    void change(int index);
private:
    //std::array<Field*, s_mapSize>m_map;
    QList<Field*> m_map;
    std::string m_mapFile;
    void load(std::string file);



signals:
    void dataChanged();


};

#endif // MAP_H
