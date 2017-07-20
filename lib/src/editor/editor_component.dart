import 'dart:html';

import 'package:angular/angular.dart';

import 'package:np8080/src/dialog/about/about_component.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/dialog/deletelines/deletelines_component.dart';
import 'package:np8080/src/dialog/generate/generate_component.dart';
import 'package:np8080/src/dialog/prepost/prepost_component.dart';
import 'package:np8080/src/dialog/replace/replace_component.dart';
import 'package:np8080/src/dialog/sequence/sequence_component.dart';
import 'package:np8080/src/dialog/timestamp/timestamp_component.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/editablelabel/editablelabel_component.dart';
import 'package:np8080/src/editor/preview_component.dart';
import 'package:np8080/src/editor/status_component.dart';
import 'package:np8080/src/resources/resources.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';
import 'package:np8080/src/storage/localstorage.dart';
import 'package:np8080/src/storage/storagekeys.dart';
import 'package:np8080/src/toolbar/toolbar_component.dart';

@Component(
    selector: 'plain-editor',
    templateUrl: 'editor_component.html',
    directives: const [
      StatusComponent,
      ToolbarComponent,
      AboutDialogComponent,
      GenerateDialogComponent,
      ReplaceDialogComponent,
      PrePostDialogComponent,
      SequenceDialogComponent,
      DeleteLinesDialogComponent,
      PreviewComponent,
      EditableLabelComponent,
      TimestampDialogComponent,
      NgFor,
      NgModel,
      NgStyle,
      NgIf,
      NgClass,
      FORM_DIRECTIVES
    ])
class EditorComponent extends EditorComponentBase {
  final List<int> _undoPositions = new List<int>();

  EditorComponent(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    themeService.load();
    showPreview = loadValue(MarkdownPreviewVisibleKey, "").length > 0;
  }

  @Input()
  TextDocument note;

  bool showAboutDialog = false;

  bool showGenerateDialog = false;

  bool showSeqDialog = false;

  bool showReplaceDialog = false;

  bool showPreview = false;

  bool showPrePostDialog = false;

  bool showDeleteLinesDialog = false;

  void changeHandler() => note.save();

  void storeStateForUndo(int cursorPos) => _undoPositions.add(cursorPos);

  bool keyHandler(KeyboardEvent e) {
    // TAB key
    if (e.keyCode == 9) {
      return tabHandler(e);
    } else if (e.keyCode == 90 && e.ctrlKey == true) {
      note.undo();
      return false;
    } else if (e.keyCode == 81 && e.ctrlKey == true) {
      eventBusService.post("showReplaceDialog");
    }

    return true;
  }

  bool tabHandler(KeyboardEvent e) {
    e.preventDefault();
    TextareaSelection selInfo = textareaDomService.getCurrentSelectionInfo();

    if (selInfo.text.length > 0) {
      String out = note.text.substring(0, selInfo.start);
      String tabbedText = textProcessingService.prefixLines(selInfo.text, tab);
      out += tabbedText;
      out += note.text.substring(selInfo.end);
      textareaDomService.setText(out);
      textareaDomService.setCursorPosition(selInfo.start + tabbedText.length);
    } else {
      textareaDomService.setText(note.text.substring(0, selInfo.start) +
          tab +
          note.text.substring(selInfo.end));
      textareaDomService.setCursorPosition(selInfo.start + tab.length);
    }

    note.updateAndSave(textareaDomService.getText());
    return false;
  }
}