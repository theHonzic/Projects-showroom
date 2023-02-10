//
// Created by honzi on 18.05.2020.
//

#ifndef ZOO_LS2020_PROJEKT_ANIMAL_H
#define ZOO_LS2020_PROJEKT_ANIMAL_H
#include <iostream>


class Animal {
protected:
    int m_calories;
    std::string m_name;
    int m_strength;
    bool m_ableToSwim;
    bool m_isDead;
    bool m_isPredator;
    bool m_isHerbivore;
    int m_height;
    bool m_visible;
    Animal();
public:
    static Animal* createAnimal(std::string name, int strength, bool swimming, int calories, bool herbivore, int height);
    int getCalories();
    std::string getName();
    int getStrength();
    bool doesItSwim();
    void setCalories(int calories);
    void setStrength(int strength);
    void setHeight(int height);
    void setVisibility(bool visibility);
    bool isItDead();
    int getHeight();
    void eat();
    bool DoesItEatOthers();
    ~Animal();
    void printInfo();
    void eatAnimal(Animal*animal);
};


#endif //ZOO_LS2020_PROJEKT_ANIMAL_H
