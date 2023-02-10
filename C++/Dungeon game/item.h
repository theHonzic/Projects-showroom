#ifndef ITEM_H
#define ITEM_H

#include <QObject>
#include <iostream>

class Item : public QObject
{
    Q_OBJECT
public:
    explicit Item(QObject *parent = nullptr);
    Item(std::string name, int healthBonus, int strengthBonus, int position, QString path);
    int getPosition();
    std::string getName();
    void hide();
    int getHealthBonus();
    int getStrengthBonus();
    static Item* createItem(char symbol, int index);
    QString getPath();
private:
    int m_healthBonus;
    QString m_imagePath;
    int m_strengthBonus;
    std::string m_name;
    int m_position;
signals:

};

#endif // ITEM_H
