//
// Created by honzi on 18.05.2020.
//

#include "Predator.h"

Predator::Predator(std::string name, int strength, bool swimming, int calories, int height) {
    m_name=name;
    setStrength(strength);
    setCalories(calories);
    setHeight(height);
    m_ableToSwim=swimming;
    m_calories=calories;
    m_isHerbivore= false;
    m_isPredator= true;
    m_isDead= false;
    m_visible=true;
}
