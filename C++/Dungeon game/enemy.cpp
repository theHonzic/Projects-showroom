#include "enemy.h"
#include <string>

Enemy::Enemy(QObject *parent) : QObject(parent)
{

}

int Enemy::getHealth()
{
    return m_health;
}

int Enemy::getDamage()
{
    return m_damage;
}

int Enemy::getStrength()
{
    return m_strength;
}

std::string Enemy::getName()
{
    return m_name;
}


void Enemy::setHealth(int health)
{
    m_health=health;
}

void Enemy::setDamage(int damage)
{
    m_damage=damage;
}

void Enemy::setStrength(int strength)
{
    m_strength=strength;
}

Enemy *Enemy::createEnemy(char symbol, int index)
{
    Enemy* enemy;
    switch (symbol) {
    case 'e':
        enemy=new Enemy(100, 12, "aggressor", index, 23, "Images/enemy.png");
        break;
    case 'f':
        enemy=new Enemy(100, 14, "zizou", index, 33, "Images/enemy2.png");
        break;
    case 'q':
        enemy=new Enemy(100, 14, "", index, 33, "Images/enemy3.png");
        break;
    }
    return enemy;
}

QString Enemy::getImagePath()
{
    return m_imagePath;
}

int Enemy::getPosition()
{
    return m_position;
}

Enemy::Enemy(int health, int damage, std::string name, int position, int strength, QString imagePath)
{
    m_health=health;
    m_damage=damage;
    m_name=name;
    m_position=position;
    m_imagePath=imagePath;
    m_strength=strength;
}
