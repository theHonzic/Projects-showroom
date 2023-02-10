#ifndef HERO_H
#define HERO_H

#include "inventory.h"
#include <QObject>
#include<iostream>
class Hero : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString m_imagePath READ getPath NOTIFY pathChanged)
public:
    explicit Hero(QObject *parent = nullptr);
    Hero(std::string name, int health, int strength);
private:
    Inventory* m_inventory;
    int m_health;
    int m_strength;
    QString m_name;
    int m_position;
    QString m_imagePath = "Images/hero.png";
    void getBonus(Item* item);
    bool m_canCarry;
    void checkInventoryStatus();
public:
    QString getPath();
    void changeCarry(bool state);
    int getPosition();
    void setPosition(int position);
    void move(int oKolik);
    void pick(Item* item);
signals:
    void pathChanged();
};

#endif // HERO_H
