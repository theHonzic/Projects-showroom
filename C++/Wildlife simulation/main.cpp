#include <iostream>
#include "Animal.h"
#include "Predator.h"
#include "Herbivore.h"
#include "Map.h"
int main() {
    Map*map=new Map();
    map->printMap();
    Animal* pes = Animal::createAnimal("Alik", 20, true, 25, false, 100);
    Animal* ryba = Animal::createAnimal("Nemo", 10, true, 10, true, 20);
    return 0;
}
