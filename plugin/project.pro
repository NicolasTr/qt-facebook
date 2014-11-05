TARGET = facebook
TEMPLATE = lib

CONFIG += qt plugin
QT += qml

DESTDIR = dist

QMAKE_CXXFLAGS += -std=c++0x

HEADERS += $$system(find src/ | grep [.]h$)
SOURCES += $$system(find src/ | grep [.]cpp$)

