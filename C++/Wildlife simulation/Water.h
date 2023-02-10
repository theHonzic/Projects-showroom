//
// Created by honzi on 18.05.2020.
//

#ifndef ZOO_LS2020_PROJEKT_WATER_H
#define ZOO_LS2020_PROJEKT_WATER_H

#include <iostream>
#include "Field.h"

class Water : public Field{
private:
    int m_waterDepth;
public:
    Water(int depth);
    void printInfo();
    void placeAnimal(Animal* animal);
};


#endif //ZOO_LS2020_PROJEKT_WATER_H
