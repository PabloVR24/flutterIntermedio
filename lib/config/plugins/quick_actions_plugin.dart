import 'package:miscelaneos/config/router/app_router.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsPlugin {
  static registerActions() {
    const QuickActions quickActions = QuickActions();

    quickActions.initialize((shortcutType) {
      print(shortcutType);
      switch (shortcutType) {
        case 'biometric':
          router.push('/biometrics');
          break;
        case 'compass':
          router.push('/compass');
          break;
        case 'pokemons':
          router.push('/pokemons');
          break;
        case 'charmander':
          router.push('/pokemons/4');
          break;
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'biometric', localizedTitle: 'BIOMETRIC', icon: 'biometrics'),
      const ShortcutItem(type: 'compass', localizedTitle: 'COMPASS', icon: 'compass'),
      const ShortcutItem(type: 'pokemons', localizedTitle: 'POKEMONS', icon: 'pokemons'),
      const ShortcutItem(type: 'charmander', localizedTitle: 'CHARMANDER', icon: 'charmander')
    ]);
  }
}
