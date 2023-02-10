//
// Created by honzi on 18.05.2020.
//

#include "Animal.h"
#include "Predator.h"
#include "Herbivore.h"

Animal * Animal::createAnimal(std::string name, int strength, bool swimming, int calories, bool herbivore, int height) {
    switch (herbivore) {
        case false:
            return new Predator (name, strength, swimming, calories, height);
            break;
        case true:
            return new Herbivore(name, strength, swimming, calories, height);
            break;
        default:
            std::cout<<"The value must be 0 or 1."<<std::endl;
            return nullptr;
            break;
    }
}

std::string Animal::getName() {
    return m_name;
}

bool Animal::doesItSwim() {
    if (m_ableToSwim==true){
        std::cout<<"Animal is able to swim"<<std::endl;
        return true;
    }else {
        std::cout<<"Animal is not able to swim"<<std::endl;
        return false;
    }
}

int Animal::getCalories() {
    return m_calories;
}

int Animal::getStrength() {
    return m_strength;
}

bool Animal::isItDead() {
    if (m_isDead==true){
        std::cout<<"Animal is alive."<<std::endl;
        return true;
    }else {
        std::cout<<"Animal is not allive."<<std::endl;
        return false;
    }
}

void Animal::setCalories(int calories) {
    if (calories<0){
        std::cout<<"The animal cannot have negative value in calories, setting calories on 0."<<std::endl;
        m_calories=0;
    } else{
        m_calories=calories;
    }
}

void Animal::setStrength(int strength) {
    if (strength<=0){
        std::cout<<"Strength must be in interval <1,100>, setting strength on 1."<<std::endl;
        m_strength=1;
    }else if (strength>100){
        std::cout<<"Strength must be in interval <1,100>, setting strength on 100."<<std::endl;
        m_strength=100;
    } else{
        m_strength=strength;
    }
}

Animal::Animal() {}

void Animal::eat() {} //TODO eat

bool Animal::DoesItEatOthers() {
    if (m_isHerbivore==true){
        return false;
    } else {
        return true;
    }
}

Animal::~Animal() {
    std::cout<<"Animal "<<m_name<<"is dead.\n";
}

void Animal::printInfo() {//TODO Vypsat souřadnice
    if (m_isPredator==true){
        std::cout<<"Predator named "<<m_name<<std::endl;
    }else {
        std::cout<<"Herbivore named "<<m_name<<std::endl;
    }
    std::cout<<"Calories: "<<m_calories<<std::endl;
    std::cout<<"Strength: "<<m_strength<<std::endl;
    std::cout<<"Height: "<<m_height<<std::endl;
    if (m_ableToSwim==true){
        std::cout<<"Animal is able to swim.\n";
    }else{
        std::cout<<"Animal is not able to swim.\n";
    }
}

void Animal::setVisibility(bool visibility) {
    m_visible=visibility;
}

void Animal::setHeight(int height) {
    if (height<=0){
        std::cout<<"You cannot be flat, setting height to 1.\n";
    }else{
        m_height=height;
    }
}

void Animal::eatAnimal(Animal *animal) { //TODO Kontrola sily a vysky
    if (m_isPredator==true){
        m_calories+=animal->getCalories();
        std::cout<<m_name<<" ate "<<animal->getName()<<". "<<animal->getName()<<" is dead.\n";
        delete animal;
    }
}

int Animal::getHeight() {
    return m_height;
}