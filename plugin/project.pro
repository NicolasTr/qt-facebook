TARGET = ntrfacebookplugin
TEMPLATE = lib

CONFIG += qt plugin
QT += qml

DESTDIR = dist

HEADERS += $$system(find src/ | grep [.]h$)
SOURCES += $$system(find src/ | grep [.]cpp$)

