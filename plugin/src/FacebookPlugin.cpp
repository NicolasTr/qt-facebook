#include "FacebookPlugin.h"

#include <QDebug>

namespace net { namespace nicolastr { namespace qt { namespace plugins {
	
void FacebookPlugin::registerTypes(const char *uri) {
    (void)uri;
    qDebug() << "Registering types for FacebookPlugin";
}
	
}}}}
