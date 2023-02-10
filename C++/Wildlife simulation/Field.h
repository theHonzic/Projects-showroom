//
// Created by honzi on 18.05.2020.
//

#ifndef ZOO_LS2020_PROJEKT_FIELD_H
#define ZOO_LS2020_PROJEKT_FIELD_H
#include <iostream>
#include "Animal.h"

class Field {
protected:
    int m_bonusCalories;
    Animal* m_animal;
    std::string m_mark;
    Field();
public:
    virtual void printInfo()=0;
    std::string getMark();
    virtual void placeAnimal(Animal* animal)=0;
};


#endif //ZOO_LS2020_PROJEKT_FIELD_H
