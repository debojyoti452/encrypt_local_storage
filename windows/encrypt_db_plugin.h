#ifndef FLUTTER_PLUGIN_ENCRYPT_DB_PLUGIN_H_
#define FLUTTER_PLUGIN_ENCRYPT_DB_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace encrypt_db {

class EncryptDbPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  EncryptDbPlugin();

  virtual ~EncryptDbPlugin();

  // Disallow copy and assign.
  EncryptDbPlugin(const EncryptDbPlugin&) = delete;
  EncryptDbPlugin& operator=(const EncryptDbPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace encrypt_db

#endif  // FLUTTER_PLUGIN_ENCRYPT_DB_PLUGIN_H_
