// マップ表示
// TODO:消すかも

void SW_boot() {
  background(100, 100, 100);
  tint(200, 200);
  image1 = loadImage("src/images/world.png");
  image(image1, 0, 0, GAME_width, GAME_height);
  noTint();
  actions("ワールドマップ");
  textFont(fontMd);
  textAlign(CENTER, CENTER);  
  image2 = loadImage("src/images/earth.png");
  image(image2, GAME_width * 1 / 4 - GAME_width / 20, GAME_height / 2 - GAME_width / 20, GAME_width / 10, GAME_width / 10);
  text("1 森の惑星", GAME_width * 1 / 4, GAME_height / 2 + GAME_width / 10);
  image3 = loadImage("src/images/neptune.png");
  image(image3, GAME_width * 2 / 4 - GAME_width / 20, GAME_height / 2 - GAME_width / 20, GAME_width / 10, GAME_width / 10);
  text("2 海の惑星", GAME_width * 2 / 4, GAME_height / 2 + GAME_width / 10);
  image4 = loadImage("src/images/mars.png");
  image(image4, GAME_width * 3 / 4 - GAME_width / 20, GAME_height / 2 - GAME_width / 20, GAME_width / 10, GAME_width / 10);
  text("3 荒廃した惑星", GAME_width * 3 / 4, GAME_height / 2 + GAME_width / 10);
  navbar("","");
}
void SW_update() {
  
}
