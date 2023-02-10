#ifndef ENEMY_H
#define ENEMY_H

#include <QObject>

class Enemy : public QObject
{
    Q_OBJECT
public:
    explicit Enemy(QObject *parent = nullptr);
    Enemy(int health, int damage, std::string name, int position, int strength, QString imagePath);
    int getHealth();
    int getDamage();
    int getStrength();
    std::string getName();
    void setHealth(int health);
    void setDamage(int damage);
    void setStrength(int strength);
    static Enemy* createEnemy(char symbol, int index);
    QString getImagePath();
    int getPosition();
private:
    int m_health;
    int m_damage;
    int m_strength;
    std::string m_name;
    int m_position;
    QString m_imagePath = "Images/hero.png"; //TODO zmenit cestu

signals:

};

#endif // ENEMY_H
