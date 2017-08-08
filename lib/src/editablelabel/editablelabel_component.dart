import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:np8080/src/dialog/common/componentbase.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'editable-label',
    templateUrl: 'editablelabel_component.html',
    directives: const [NgModel, NgStyle, NgClass, formDirectives])
class EditableLabelComponent extends ComponentBase implements OnInit {
  final StreamController onTextChange = new StreamController();

  bool editMode = false;
  String outputText;

  @Input()
  String text;

  @Output()
  Stream<String> get textChange => onTextChange.stream;

  EditableLabelComponent(
      ThemeService newthemeService, EventBusService newEventBusService)
      : super(newthemeService, newEventBusService) {
    editMode = false;
    eventBusService.subscribe('resetEditableTable', reset);
  }

  ngOnInit() => formatText();

  void update() {
    onTextChange.add(text);
    formatText();
  }

  void formatText() {
    outputText = text.length < 18 ? text : text.substring(0, 15) + "...";
    document.title = text;
  }

  void toggle() {
    editMode = !editMode;
    if (editMode) {
      TextInputElement tb = querySelector("#editbox");
      tb.focus();
    } else if (text.length == 0) {
      reset();
    }
  }

  void reset() {
    text = defaultDownloadName;
    update();
  }

  void clickTabXHandler() => eventBusService.post("closeEditorTabPrompt");

  String getTabsClass() => themeService.secondaryClass;
}
