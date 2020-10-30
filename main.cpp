#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSslSocket>

#include "statusbar.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qDebug() << "Device supports OpenSSL: " << QSslSocket::supportsSsl();

    qmlRegisterType<StatusBar>("StatusBar", 0, 1, "StatusBar"); // <==

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
