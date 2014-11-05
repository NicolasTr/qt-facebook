TARGET = facebook-example
TEMPLATE = app

CONFIG += qt
QT += qml

DESTDIR = dist

QMAKE_CXXFLAGS += -std=c++0x

HEADERS += $$system(find src/ | grep [.]h$)
SOURCES += $$system(find src/ | grep [.]cpp$)
OTHER_FILES += $$system(find qml/ | grep [.]qml$)
RESOURCES += project.qrc

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
