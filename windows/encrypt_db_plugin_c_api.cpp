#include "include/encrypt_db/encrypt_db_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "encrypt_db_plugin.h"

void EncryptDbPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  encrypt_db::EncryptDbPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
