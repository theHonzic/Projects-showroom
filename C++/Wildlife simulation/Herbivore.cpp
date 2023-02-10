//
// Created by honzi on 18.05.2020.
//

#include "Herbivore.h"

Herbivore::Herbivore(std::string name, int strength, bool swimming, int calories, int height) {
    m_name=name;
    setStrength(strength);
    setCalories(calories);
    setHeight(height);
    m_ableToSwim=swimming;
    m_calories=calories;
    m_isHerbivore= true;
    m_isPredator= false;
    m_isDead= false;
    m_visible= true;
}