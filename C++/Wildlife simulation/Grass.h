//
// Created by honzi on 18.05.2020.
//

#ifndef ZOO_LS2020_PROJEKT_GRASS_H
#define ZOO_LS2020_PROJEKT_GRASS_H


#include "Field.h"

class Grass : public Field{
private:
    int m_grassLength;
public:
    Grass(int length);
    void printInfo();
    void placeAnimal(Animal* animal);
};


#endif //ZOO_LS2020_PROJEKT_GRASS_H
