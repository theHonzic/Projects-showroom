//
// Created by honzi on 02.06.2020.
//

#ifndef ZOO_LS2020_PROJEKT_MAP_H
#define ZOO_LS2020_PROJEKT_MAP_H
#include <array>
#include <iostream>
#include "Field.h"
#include "Water.h"
#include "Grass.h"

class Map {
private:
    std::array<std::array<Field*,5>,5>m_map;
public:
    Map();
    void printMap();
};


#endif //ZOO_LS2020_PROJEKT_MAP_H
