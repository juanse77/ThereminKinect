
public final String[] modes = new String[]{Mode.IDLE.toString(), Mode.AUTOMATIC.toString(), Mode.FREE.toString(), Mode.GAME_WITH_HELP.toString(), Mode.GAME_WITHOUT_HELP.toString()};

class ModesMenu {
  
  private final ButtonBar b;
  
  ModesMenu(ControlP5 cp5) {
    b = cp5.addButtonBar("modes_menu")
     .setPosition(0, 0)
     .setSize(cp5.papplet.width, 20)
     .addItems(modes);
    b.changeItem(Mode.IDLE.toString(), "selected", true);
  }
  
  void selectMode(Mode mode) {
    // Selecciona modo y deselecciona demas
    b.changeItem(mode.toString(), "selected", true);
    for(Mode m:Mode.values()) {
      if(m != mode) b.changeItem(m.toString(), "selected", false);;
    }
  }
  
}

void modes_menu(int item) {
  
  switch(item) {
    case 0:
      if (game.isRunning()) {
        game.stop_music();
      } else {
        game.setIdle();
      }
      mcm.enable();
      break;
    case 1:
      if (game.isRunning()) {
        game.stop_music();
      }
  
      game.runAutomaticMode();
      mcm.disable();
      break;
    case 2:
      if (game.isRunning()) {
        game.stop_music();
      }
  
      game.runFree();
      mcm.disable();
      break;
    case 3:
      if (game.isRunning()) {
        game.stop_music();
      }
  
      numPlayer++;
      game.runGameWithHelpMode(numPlayer, "Player " + numPlayer);
      mcm.disable();
      break;
    case 4:
      if (game.isRunning()) {
        game.stop_music();
      }
  
      numPlayer++;
      game.runGameWithoutHelpMode(numPlayer, "Player " + numPlayer);
      mcm.disable();
      break;
    default:
      println("No mode");
      break;
  }
}
