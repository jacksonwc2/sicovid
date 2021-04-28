import 'package:flutter/material.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(title: "Preferências", children: [
      // as opções de configuração que eu teria, por exemplo cor
      MaterialColorPickerSettingsTile(
          settingKey: 'pref_background_color', title: 'Cor de fundo'),
      SwitchSettingsTile(settingKey: 'pref_show_photo', title: 'Exibir Foto?')
    ]);
  }
}
