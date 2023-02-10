#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "map.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext* context = engine.rootContext();

    Map* map= new Map("C:/Users/honzi/Desktop/repos/cppzs2020_xjanovec/project/map.txt");
    context->setContextProperty("map", map);


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
