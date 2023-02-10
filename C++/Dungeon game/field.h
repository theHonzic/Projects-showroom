#ifndef FIELD_H
#define FIELD_H

#include <hero.h>
#include <QObject>

class Field : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString m_imagePath READ getImagePath NOTIFY fieldChanged)
public:
    explicit Field(QObject *parent = nullptr);
private:
    Field(std::string type, int position, double damage, QString imagePath);
    std::string m_type;
    int m_position;
    double m_damage;
    QString m_imagePath;
    Hero* hero;

public:
    QString getImagePath();
    int getPosition();
    std::string getType();
    double getDamage();
    void setPosition(int position);
    static Field* createField(char symbol, int index);
    void setHero(Hero* hero);
    void changePath();
    void doChange();
signals:
    void fieldChanged();
};

#endif // FIELD_H
