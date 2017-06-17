import 'package:angular2/angular2.dart' show NgStyle, NgModel, FORM_DIRECTIVES;
import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'prepost-dialog',
    templateUrl: 'prepost_component.html',
    directives: const [NgModel, NgStyle, FORM_DIRECTIVES])
class PrePostDialogComponent extends DialogBase {

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;
  final EventBusService _eventBusService;

  @Input()
  TextDocument note;

  String prefix = "";
  String postfix = "";

  PrePostDialogComponent(this._textProcessingService,
      this._textareaDomService, this._eventBusService) {
    this._eventBusService.subscribe("showPrePostDialog", show);
  }

  void closeTheDialog() {
    close();
    _textareaDomService.setFocus();
  }

  performPrePost() {
    if (prefix.length + postfix.length > 0) {
      String txt = note.text;
      if (prefix.length > 0)
        txt = _textProcessingService.prefixLines(txt, prefix);
      if (postfix.length > 0)
        txt = _textProcessingService.postfixLines(txt, postfix);

      note.updateAndSave(txt);
    }
  }
}