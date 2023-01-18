//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <encrypt_db/encrypt_db_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) encrypt_db_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "EncryptDbPlugin");
  encrypt_db_plugin_register_with_registrar(encrypt_db_registrar);
}
