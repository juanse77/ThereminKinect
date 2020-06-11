
class ModesMenu {
  ModesMenu(ControlP5 cp5) {
    /*
    ButtonBar b = cp5.addButtonBar("modes_menu")
     .setPosition(0, 0)
     .setSize(cp5.papplet.width, 20)
     .addItems(new String[]{"Idle", "Automatic", "Free", "Game with help", "Game without help"});
     */
     int totalWidth = floor(cp5.papplet.width);
     int totalHeight = 20;
     int nmodes = Mode.values().length;
     
     for(int i=0; i < nmodes; i++) {
       cp5.addButton(Mode.values()[i].toString())
        .setPosition(i*(totalWidth/nmodes), 0)
        .setSize(totalWidth/nmodes, 20)
        .setLabel(Mode.values()[i].toString().replace("_"," "));
     }
     
     
  }
}

void controlEvent(CallbackEvent event) {
  if (event.getAction() == ControlP5.ACTION_CLICK) {
    switch(event.getController().getAddress()) {
    case "/IDLE":
      if (game.isRunning()) {
        game.stop_music();
      } else {
        game.setIdle();
      }
      mcm.enable();
      break;
    case "/AUTOMATIC":
      if (game.isRunning()) {
        game.stop_music();
      }
  
      game.runAutomaticMode();
      mcm.disable();
      break;
    case "/FREE":
      if (game.isRunning()) {
        game.stop_music();
      }
  
      game.runFree();
      mcm.disable();
      break;
    case "/GAME_WITH_HELP":
      if (game.isRunning()) {
        game.stop_music();
      }
  
      numPlayer++;
      game.runGameWithHelpMode(numPlayer, "Player " + numPlayer);
      mcm.disable();
      break;
    case "/GAME_WITHOUT_HELP":
      if (game.isRunning()) {
        game.stop_music();
      }
  
      numPlayer++;
      game.runGameWithoutHelpMode(numPlayer, "Player " + numPlayer);
      mcm.disable();
      break;
    }
  }
}
