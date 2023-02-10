//
// Created by honzi on 18.05.2020.
//

#ifndef ZOO_LS2020_PROJEKT_HERBIVORE_H
#define ZOO_LS2020_PROJEKT_HERBIVORE_H
#include <iostream>
#include "Animal.h"

class Herbivore : public Animal{
public:
    Herbivore(std::string name, int strength, bool swimming, int calories, int height);
};


#endif //ZOO_LS2020_PROJEKT_HERBIVORE_H
