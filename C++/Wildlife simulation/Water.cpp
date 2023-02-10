//
// Created by honzi on 18.05.2020.
//

#include "Water.h"

Water::Water(int depth) {
    m_waterDepth=depth;
    m_bonusCalories=15;
    m_mark="W";
    m_animal= nullptr;
}

void Water::printInfo() {
    std::cout<<"Field with water:\n";
    std::cout<<"Calories: "<<m_bonusCalories<<std::endl;
    std::cout<<"Water depth: "<<m_waterDepth<<std::endl;
}

void Water::placeAnimal(Animal *animal) {
    if (m_animal== nullptr){
        if (animal->doesItSwim()==true){
            animal->setCalories(animal->getCalories()+m_bonusCalories);
            std::cout<<"Animal "<<animal->getName()<<" drank water +"<<m_bonusCalories<<" calories.\n";
            m_animal=animal;
        }else if (animal->doesItSwim()==false){
            if (m_waterDepth<animal->getHeight()){
                animal->setCalories(animal->getCalories()+m_bonusCalories);
                std::cout<<"Animal "<<animal->getName()<<" drank water +"<<m_bonusCalories<<" calories.\n";
                m_animal=animal;
            }else if (m_waterDepth>=animal->getHeight()){
                std::cout<<"Animal "<<animal->getName()<<" drowned. It is dead.";
                delete animal;
            }
        }
    }else if (m_animal!= nullptr){
        if (m_animal->getStrength()>animal->getStrength()){
            m_animal->eatAnimal(animal);
            std::cout<<"Animal"<<m_animal->getName()<<" ate "<<animal->getName()<<".\n";
            delete animal;
        }else if (m_animal->getStrength()<animal->getStrength()){
            animal->eatAnimal(m_animal);
            std::cout<<"Animal"<<animal->getName()<<" ate "<<m_animal->getName()<<".\n";
            delete m_animal;
            m_animal= nullptr;
        }else {
            std::cout<<"Animals are trying to eat each other, it is a draw though.\n";

        }
    }
}