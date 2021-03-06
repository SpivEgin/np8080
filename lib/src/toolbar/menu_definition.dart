import 'package:np8080/src/resources/resources.dart';
import 'package:np8080/src/toolbar/toolbar.dart';

class Menu {
  final String name;
  final String tooltip;
  final Function handler;
  final bool separator;

  Menu(this.name,
      [this.handler = null, this.tooltip = '', this.separator = false]);
}

class MenuDefinition {
  final List<Menu> startMenuItems = new List<Menu>();
  final List<Menu> modifyMenuItems = new List<Menu>();
  final List<Menu> addMenuItems = new List<Menu>();
  final List<Menu> removeMenuItems = new List<Menu>();
  final List<Menu> advancedMenuItems = new List<Menu>();
  final List<Menu> viewMenuItems = new List<Menu>();
  final List<Menu> helpMenuItems = new List<Menu>();

  void buildMenus(Toolbar toolbar) {
    startMenuItems.addAll([
      new Menu("Clear Text", toolbar.clearHandler,
          "Start again with an empty file.", true),
      new Menu("Welcome Text", toolbar.sampleHandler,
          "Put sample text into the file."),
      new Menu("Markdown", toolbar.markdownSampleHandler,
          "Put sample Markdown into the file.")
    ]);

    modifyMenuItems.addAll([
      new Menu("Replace...", toolbar.replaceHandler,
          "Replace some text with some other text.\tShortcut - Ctrl + Q"),
      new Menu("Pre/Post...", toolbar.prePostHandler,
          "Add text to start and/or end of lines.", true),
      new Menu("Doublespace", toolbar.doublespaceHandler,
          "Double space the lines.", true),
      new Menu("Split...", toolbar.splitHandler,
          "Split into separate lines by a delimiter."),
      new Menu("Single Line", toolbar.oneLineHandler,
          "Put all the text onto one line.", true),
      new Menu("Reverse", toolbar.reverseHandler, "Reverse the line order."),
      new Menu("Randomise", toolbar.randomHandler, "Randomise the line order.",
          true),
      new Menu("Sort A-Z", toolbar.sortHandler, "Alphabetically sort lines."),
      new Menu("Number", toolbar.numberHandler, "Number non-blank lines.")
    ]);

    addMenuItems.addAll([
      new Menu("Timestamp...", toolbar.timestampDlgHandler,
          "Choose a timestamp to add to the document.", true),
      new Menu("Duplicate All", toolbar.duplicateHandler,
          "Append a copy of the entire text to itself."),
      new Menu("Duplicate Lines", toolbar.dupeHandler,
          "Add a copy of a line to itself.", true),
      new Menu("Generate Text...", toolbar.generateHandler,
          "Add generated text into document."),
      new Menu("Num Sequence...", toolbar.generateSeqHandler,
          "Add generated number sequence to document.")
    ]);

    removeMenuItems.addAll([
      new Menu("Trim", toolbar.trimFileHandler,
          "Remove proceeding and trailing whitespace from file."),
      new Menu("Trim Lines", toolbar.trimLinesHandler,
          "Remove proceeding and trailing whitespace from each line.", true),
      new Menu("Blank Lines", toolbar.removeBlankLinesHandler,
          "Remove all blank lines."),
      new Menu("Extra Blank Lines", toolbar.removeExtraBlankLinesHandler,
          "Remove extra blank lines.", true),
      new Menu("Lines containing...", toolbar.removeLinesContaining,
          "Remove lines containing (or NOT) a string."),
    ]);

    advancedMenuItems.addAll([
      new Menu("Uri Encode", toolbar.uriEncodeHandler,
          "Encode the text for use in a Uri."),
      new Menu("Uri Decode", toolbar.uriDecodeHandler,
          "Decode the text from a Uri.", true),
      new Menu("Unescape HTML", toolbar.htmlUnescapeHandler, "Unescape HTML."),
    ]);

    viewMenuItems.addAll([
      new Menu("Themes...", toolbar.themesHandler,
          "Choose a colour theme for NP8080."),
      new Menu("Markdown", toolbar.markdownHandler,
          "Show a rendering of Markdown alongside the text.", true),
      new Menu("Side By side", toolbar.dualReaderHandler,
          "Show texts alongside each other."),
      new Menu("Reader", toolbar.readerHandler,
          "Show a full screen readonly view of the text.")
    ]);

    helpMenuItems.addAll([
      new Menu("About", toolbar.aboutHandler, "Find out more about NP8080."),
      new Menu(
          "Manual", toolbar.manualHandler, "Read the NP8080 manual.", true),
      new Menu("What's New?", toolbar.whatsNewHandler,
          "Find out what's changed! - Hosted on Github.com.", true),
      new Menu("GitHub", toolbar.githubHandler,
          "Get the source code - Hosted on Github.com."),
      new Menu("Gitter Chat", toolbar.gitterHandler,
          "Gitter based Chatroom - Hosted on Gitter.com.")
    ]);

    buildManual();
  }

  void buildManual() {
    List<Menu> allMenus = new List<Menu>();

    Menu blank = new Menu(" ");
    allMenus.add(new Menu("Start Menu"));
    allMenus.add(blank);
    allMenus.addAll(startMenuItems);
    allMenus.add(blank);

    allMenus.add(new Menu("Modify Menu"));
    allMenus.add(blank);
    allMenus.addAll(modifyMenuItems);
    allMenus.add(blank);

    allMenus.add(new Menu("Add Menu"));
    allMenus.add(blank);
    allMenus.addAll(addMenuItems);
    allMenus.add(blank);

    allMenus.add(new Menu("Remove Menu"));
    allMenus.add(blank);
    allMenus.addAll(removeMenuItems);
    allMenus.add(blank);

    allMenus.add(new Menu("Advanced Menu"));
    allMenus.add(blank);
    allMenus.addAll(advancedMenuItems);
    allMenus.add(blank);

    allMenus.add(new Menu("View Menu"));
    allMenus.add(blank);
    allMenus.addAll(viewMenuItems);
    allMenus.add(blank);

    allMenus.add(new Menu("Help Menu"));
    allMenus.add(blank);
    allMenus.addAll(helpMenuItems);

    np8080Manual = np8080ManualIntro;
    allMenus.forEach((Menu menu) {
      np8080Manual += menu.name.padRight(20) + menu.tooltip + '\r\n';
    });
  }
}
