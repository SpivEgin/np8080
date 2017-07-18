import 'package:angular/angular.dart';
import 'package:np8080/dialog/common/editorcomponentbase.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'generate-dialog',
    templateUrl: 'generate_component.html',
    directives: const [NgClass, NgModel, NgStyle, NgClass, FORM_DIRECTIVES])
class GenerateDialogComponent extends EditorComponentBase {
  String textToRepeat;

  num repeatCount = 10;

  GenerateDialogComponent(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showGenerateDialog", initialiseAndShow);
  }

  void initialiseAndShow() {
    textToRepeat = "";
    show();
  }

  String getGeneratedText() {
    if (textToRepeat == null) return '';

    generatedText = textProcessingService.generateRepeatedString(
        textToRepeat, repeatCount, newLineAfter);
    return generatedText;
  }
}
