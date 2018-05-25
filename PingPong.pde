void setup() {
  size(800, 600);
}

float w= float(width);
float h = float(height);
color bg = #05BEFF;
color table = #000000;
color outside = #55BE0F;
color bat = #55BE0F;
color ball = #FFFFFF;
color wall = #9C00FF;
char char0;
float tableW=600, tableH = 300, tableX=100, tableY=150; // asztal szélesség, magasság, kezdőx, kezdő y  //tableW =>tableWidth, tableH =>tableHeight
float tileX, tileY, tileWidth=tableW/60;  
float ballX=400, ballY=300, ballR=8, ballSpeedX=1, ballSpeedY=1;
float speed = 2, placeX, placeY;
int row, col, x, y, xNum, yNum;
char tile;

float batWidth=7, batHeight=30, batLX=120, batLY=300-batHeight/2, batRX=673, batRY=batLY ;

void draw() {
  noStroke();
  background(bg);
  String[] tiles = loadStrings("pingpong0.60.txt"); //betölti a pingpong0.txt fájlt
  for (row =0; row < tiles.length; row++) { //sorok

    for (col =0; col <tiles[row].length(); col++) { //oszlopok
      tile = tiles[row].charAt(col); //tömb[sor].charAt(oszlop) => tömb adott sorában és oszlopában lévő karakter

      print(tile); //kiírja a tile értékét ellenőrzésre jó
      if (tile == '0') { //0=külső határ
        fill(outside);
      } else if (tile =='1') { //1=asztal
        fill(table);
      } else if (tile == '2') {
        fill(wall);
      }

      rect(tileWidth*col+tableX, tileWidth*row+tableY, tileWidth, tileWidth);
    }
  }

  keyPressed();

  batR();
  batL();
  ball();
  ballMove();
  wall();
  bat();
  //hit();
}
void keyPressed() {
  println("pressed " + int(key) + " " + keyCode);

  switch(keyCode) {
  case UP: //fel //right up
    rightUp();
    break;
  case DOWN: //le //right down
    rightDown();
    break;
  case 87: //W //left up
    leftUp();
    break;
  case 83: //S //left down
    leftDown();
    break;
  }

  keyCode=0;
}
/*void hit() {
  String[] tiles = loadStrings("pingpong0.60.txt"); //betölti a pingpong0.txt fájlt
  for (x=int(ballX-ballR); x < int(ballX+ballR); x++) {
    for (y=int(ballY-ballR); y <int(ballY+ballR); y++) {

      if (dist(ballX+ballSpeedX, ballY+ballSpeedY, x, y)<ballR) {
        row = x-100/100;
        col = y-150/100;
        tile = tiles[row].charAt(col); //tömb[sor].charAt(oszlop) => tömb adott sorában és oszlopában lévő karakter

        println(tile); //kiírja a tile értékét ellenőrzésre jó
      }
    }
  }
}*/
void ball() { //kirajzolja a labdát
  fill(ball);
  ellipse(ballX, ballY, ballR, ballR);
}
void ballMove() { //mozgatja a labdát
  ballX= ballX + ballSpeedX;
  ballY = ballY + ballSpeedY;
}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!/
void bat() {//ha lepattan az ütőről
  for (x=0; x< batWidth; x++ ) {
    for (y=0; y< batHeight; y++) {
      if (dist(ballX, ballY, batRX+x, batRY+y) < ballR ||dist(ballX, ballY, batLX+x, batLY+y) < ballR) {
        if (int(ballX+ballR) != batRX+x|| ballX != batLX+x) {
          ballSpeedX = -ballSpeedX;
        }
        if (int(ballY+ballR) != batRY+y || ballY != batLY+y) {
          ballSpeedY = -ballSpeedY;
        }
      }
    }
  }
}

void wall() { //ha falhoz ütközik
  if (ballX <= (width-tableW)/2+tileWidth || ballX >= tableW+(width-tableW)/2-tileWidth) {
    if (int(ballX) != (width-tableW)/2 || ballX != tableW+(width-tableW)/2) {
      ballSpeedX = -ballSpeedX;
    }
  }
  if (ballY <= (height-tableH)/2+tileWidth || ballY >= tableH+(height-tableH)/2-tileWidth) {
    if (int(ballY) !=(height-tableH)/2 || ballY != tableH+(height-tableH)/2) {
      ballSpeedY = -ballSpeedY;
    }
  }
}


void smash() {//ha összetörhető falhoz érkezik
  ballSpeedX = ballSpeedX*0.9;
  ballSpeedY = ballSpeedY*0.9;
}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!/

/*for (x=int(ballX-ballR); x<int(ballX+ballR); x++) {
 for (y=int(ballY-ballR); x<int(ballY+ballR); x++) {
 row = int((x-100)/10);
 col = int((y-150)/10);
 tile = tiles[row].charAt(col);
 if (tile == '0') { //0=külső határ
 println("out");
 } else if (tile =='1') { //1=asztal
 println("in");
 } else if (tile == '2') {
 println("smash");
 }
 }*/

void batR() { //jobb oldali ütő //mozgatás -> nyilakkal
  fill(bat);
  rect(batRX, batRY, batWidth, batHeight);
}
void batL() { //jobb oldali ütő //mozgatás -> SW
  fill(bat);
  rect(batLX, batLY, batWidth, batHeight);
}


void leftUp() {
  if (batLY>150+speed+tileWidth) {
    batLY = batLY - speed;
  } else {
    //leftDown();
  }
}
void leftDown() {
  if (batLY+batHeight < 450-speed-tileWidth) {
    batLY = batLY + speed;
  } else {
    //leftUp();
  }
}
void rightUp() {
  if (batRY>150+speed+tileWidth) {
    batRY = batRY - speed;
  } else {
    //rightDown();
  }
}
void rightDown() {
  if (batRY+batHeight < 450-speed-tileWidth) {
    batRY = batRY + speed;
  } else {
    //rightUp();
  }
}

void midleX() { //berajzolja a vízszintes felezővolat (csak segédletnek)
  fill(bat);
  rect(0, height/2, width, 1);
}
