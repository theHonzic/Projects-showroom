//
// Created by honzi on 18.05.2020.
//

#ifndef ZOO_LS2020_PROJEKT_PREDATOR_H
#define ZOO_LS2020_PROJEKT_PREDATOR_H
#include "Animal.h"
#include <iostream>

class Predator :public Animal {
public:
    Predator(std::string name, int strength, bool swimming, int calories, int height);

};


#endif //ZOO_LS2020_PROJEKT_PREDATOR_H
