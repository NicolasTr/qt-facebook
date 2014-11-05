#ifndef FACEBOOK_PLUGIN_H
#define FACEBOOK_PLUGIN_H

#include <QQmlExtensionPlugin>

namespace net { namespace nicolastr { namespace qt { namespace plugins {

class FacebookPlugin : public QQmlExtensionPlugin {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);

};

}}}}

#endif // FACEBOOK_PLUGIN_H
