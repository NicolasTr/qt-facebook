#include "NtrFacebookPlugin.h"

#include <QDebug>

namespace net { namespace nicolastr { namespace qt { namespace plugins {
	
void NtrFacebookPlugin::registerTypes(const char *uri) {
	(void)uri;
	qDebug() << "Registering types for plugin NtrFacebookPlugin";
}
	
}}}}
