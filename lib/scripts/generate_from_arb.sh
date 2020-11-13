#!/bin/sh
DIRECTORY="lib/generated"
mkdir -p $DIRECTORY
flutter packages pub run intl_translation:generate_from_arb --output-dir lib/generated --no-use-deferred-loading lib/i18n.dart lib/resources/messages/intl_*.arb