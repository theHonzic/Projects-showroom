#ifndef INVENTORY_H
#define INVENTORY_H

#include "item.h"

#include <QObject>

class Inventory : public QObject
{
    Q_OBJECT
public:
    explicit Inventory(QObject *parent = nullptr);
    void addItem(Item* item);
    void removeItem(int which);
    int getSize();

private:

    QList<Item*>m_items;

signals:

};

#endif // INVENTORY_H
