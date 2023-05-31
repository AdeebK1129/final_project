PImage board;
PImage spare;
PImage save;
PVector holes[] = new PVector[6];
PVector coord;
int size;
int row;
boolean done;
int start = 0;
color pieceColor = color(0, 0, 255);
int colorNum = 1;
int targetY = 770;

void setup() {
  size(792, 770);
  fill(200);
  text(mouseX, 10, 10);
  text(mouseY, 10, 30);
  
  board = loadImage("board.png");
  spare = board.copy();
  save = board.copy();
  size = 42; // Updated size to half of the desired diameter (75 pixels)
  row = 0;
  coord = new PVector(row * 94 + 118, 40); // Adjusted y-coordinate to position the initial game piece above the first column
  done = false;
}

Board gameBoard = new Board();

public int findTargetYCor(int xCor) {
  int column = (xCor - 118) / 90; // Calculate the column based on xCor (adjust the values according to your specific layout)
  
  if (column >= 0 && column < gameBoard.getColumns()) {
    for (int row = gameBoard.getRows() - 1; row >= 0; row--) {
      if (!gameBoard.getCell(row, column).isOccupied()) {
        return gameBoard.getCell(row, column).getYCor();
      }
    }
  }
  return -1; // Indicates that no empty cell was found in the column
}

void draw() {
  if (coord.y <= 40) row = mouseX / 94 - 1;
  if (mouseX >= 118 && mouseX <= 718) coord.x = row * 94 + 118;
  for (int i = 0; i < 6; i++) holes[i] = new PVector(row * 94 + 118, 178 + 94 * i);

  image(board, 0, 0); 
  if (coord.y < 655 && start == 1) {
    float distance = targetY - coord.y;
    float stepSize = distance / 15; 
    coord.y += stepSize;
  } else if (coord.y > 730) {
    coord.y = 730;
  }

  board.loadPixels();

  for (int y = 0; y < board.height; y++) {
    for (int x = 0; x < board.width; x++) {

      boolean withinHoles = false;
      for (int i = 0; i < 6; i++) {
        if (sqrt(pow((x - holes[i].x), 2) + pow((y - holes[i].y), 2)) <= size) {
          withinHoles = true;
          break;
        }
      }

      boolean withinCoord = sqrt(pow((coord.x - x), 2) + pow((coord.y - y), 2)) <= size;

      if ((withinHoles || y < 178) && withinCoord) {
        board.set(x, y, pieceColor);
        if (sqrt(pow((x - holes[5].x), 2) + pow((y - holes[5].y), 2)) <= size) {
          save.set(x, y, board.get(x, y));
        }
      } else {
        board.set(x, y, save.get(x, y));
      }
    }
  }

  board.updatePixels();
}



void keyPressed(){ //restart the demo
  if (key == 'f') start = 1;
  else{
  start = 0;
  coord.y = 40;
  board.loadPixels();
  if(key == 's'){
     board = save.copy();
     if(pieceColor == color(0, 0, 255)) pieceColor = color(255, 0, 0);
     else pieceColor = color(0, 0, 255);
     if(colorNum == 1) colorNum = 2;
     else colorNum = 1;
  }
  board.updatePixels();
  }
}

void mousePressed() {
  if (coord.y == 40) {
    start = 1;
    int targetX = mouseX;
    targetY = findTargetYCor(targetX);
    gameBoard.updateBoard(targetX, colorNum);
    System.out.println(gameBoard);
  }
}
