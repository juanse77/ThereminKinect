
class ModesMenu {
  ModesMenu(ControlP5 cp5) {
    ButtonBar b = cp5.addButtonBar("modes_menu")
     .setPosition(0, 0)
     .setSize(cp5.papplet.width, 20)
     .addItems(new String[]{"Idle", "Automatic", "Free", "Game with help", "Game without help"})
     ;
  }
}

void modes_menu(int n) {
  switch(n) {
    case 0: // IDLE
      if (game.isRunning()) {
        game.stop_music();
      } else {
        game.setIdle();
      }
      break;
    case 1: // Automatic
      if (game.isRunning()) {
        game.stop_music();
      }
  
      game.runAutomaticMode();
      break;
    case 2: // Free
      if (game.isRunning()) {
        game.stop_music();
      }
  
      game.runFree();
      break;
    case 3: // Game with help
      if (game.isRunning()) {
        game.stop_music();
      }
  
      numPlayer++;
      game.runGameWithHelpMode(numPlayer, "Player " + numPlayer);
      break;
    case 4: // Game without help
      if (game.isRunning()) {
        game.stop_music();
      }
  
      numPlayer++;
      game.runGameWithoutHelpMode(numPlayer, "Player " + numPlayer);
      break;
    default:
      
      break;
  }
}
