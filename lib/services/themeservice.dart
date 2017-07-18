import 'package:angular/angular.dart';
import 'package:np8080/storage/localstorage.dart';
import 'package:np8080/storage/storagekeys.dart';

@Injectable()
class ThemeService {
  String _theme = 'default';

  String get theme => _theme;

  String get mainClass => _theme + '-theme-1';

  String get secondaryClass => _theme + '-theme-2';

  String get documentClass => _theme + '-document';

  void load() => _theme = loadValue(SelectedThemeKey, 'default');

  set theme(String newTheme) {
    _theme = newTheme;
    storeValue(SelectedThemeKey, newTheme);
  }
}
