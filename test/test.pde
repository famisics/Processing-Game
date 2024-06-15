import controlP5.*;
import java.util.ArrayList;

ControlP5 cp5;
ArrayList<ButtonData> buttons;
int buttonCount = 0;

void setup() {
  size(800, 600);
  cp5 = new ControlP5(this);
  buttons = new ArrayList<ButtonData>();

  // 初期ボタンのデータを追加
  buttons.add(new ButtonData("Button 1", 100, 100, 200, 100, "path/to/image1.png", this::buttonPressed1));
  buttons.add(new ButtonData("Button 2", 350, 100, 200, 100, "path/to/image2.png", this::buttonPressed2));
  buttons.add(new ButtonData("Button 3", 600, 100, 200, 100, "path/to/image3.png", this::buttonPressed3));

  // 各ボタンを作成
  for (ButtonData btnData : buttons) {
    createButton(btnData);
  }
}

void draw() {
  background(240);
}

void createButton(ButtonData btnData) {
  PImage buttonImage = loadImage(btnData.imagePath);

  cp5.addButton(btnData.label)
     .setPosition(btnData.x, btnData.y)
     .setSize(btnData.width, btnData.height)
     .setImage(buttonImage)
     .onClick(btnData.callback);
}

void addButton(String label, int x, int y, int width, int height, String imagePath, CallbackListener callback) {
  ButtonData newButton = new ButtonData(label, x, y, width, height, imagePath, callback);
  buttons.add(newButton);
  createButton(newButton);
}

void removeAllButtons() {
  for (ButtonData btnData : buttons) {
    cp5.remove(btnData.label);
  }
  buttons.clear();
}

void buttonPressed1(CallbackEvent event) {
  println("Button 1 pressed!");
}

void buttonPressed2(CallbackEvent event) {
  println("Button 2 pressed!");
}

void buttonPressed3(CallbackEvent event) {
  println("Button 3 pressed!");
}

void newButtonPressed(CallbackEvent event) {
  println("New Button pressed!");
}

class ButtonData {
  String label;
  int x, y, width, height;
  String imagePath;
  CallbackListener callback;

  ButtonData(String label, int x, int y, int width, int height, String imagePath, CallbackListener callback) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.imagePath = imagePath;
    this.callback = callback;
  }
}

// キーが押されたときの処理
void keyPressed() {
  if (key == 'r') { // 'r'キーを押すと全てのボタンを削除
    removeAllButtons();
  }
  if (key == 'a') { // 'a'キーを押すと新しいボタンを追加
    buttonCount++;
    String label = "New Button " + buttonCount;
    addButton(label, (int)random(width - 200), (int)random(height - 100), 200, 100, "path/to/image.png", this::newButtonPressed);
  }
}
