//
// Created by honzi on 18.05.2020.
//

#include "Grass.h"

Grass::Grass(int length) {
    m_animal= nullptr;
    m_bonusCalories=10;
    m_mark="G";
    m_grassLength=length;
}

void Grass::printInfo() {
    std::cout<<"Field with grass:\n";
    std::cout<<"Calories: "<<m_bonusCalories<<std::endl;
    std::cout<<"Length of grass: "<<m_grassLength<<std::endl;
}

void Grass::placeAnimal(Animal *animal) {
    //TODO do
}