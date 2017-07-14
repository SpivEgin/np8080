import 'package:angular/angular.dart';
import 'package:intl/intl.dart';
import 'package:np8080/dialog/common/npdialogbase.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'timestamp-dialog',
    templateUrl: 'timestamp_component.html',
    directives: const [
      NgFor, NgClass, NgModel, NgStyle, NgSelectOption, FORM_DIRECTIVES])
class TimestampDialogComponent extends NpEditDialogBase {

  final List<String> times = new List<String>();

  String timeStamp = '';

  TimestampDialogComponent(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newTextProcessingService, newTextareaDomService, newthemeService,
      newEventBusService) {
    eventBusService.subscribe("showTimestampDialog", show);
    updateTime();
    timeStamp = times[0];
  }

  String getGeneratedText() {
    generatedText = timeStamp;
    return timeStamp;
  }

  void updateTime() {
    DateTime currentTime = new DateTime.now();
    times.clear();
    times.addAll([
      currentTime.toString(),
      formatDateTime(currentTime, 'EEEE h:m a'),
      formatDateTime(currentTime, 'EEEE H:m'),
      formatDateTime(currentTime, 'yyyy-MM-dd'),
      formatDateTime(currentTime, 'h:m:ss'),
      formatDateTime(currentTime, 'H:m:ss'),
      formatDateTime(currentTime, 'EEEE H:m:ss'),
      formatDateTime(currentTime, 'EEEE h:m:ss a')
    ]);
    timeStamp = currentTime.toString();
  }

  String formatDateTime(DateTime dateTime, String pattern) {
    return new DateFormat(pattern).format(dateTime);
  }
}