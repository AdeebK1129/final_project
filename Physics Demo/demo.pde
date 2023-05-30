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
// random test comment update test

void setup(){
  row = 0;
  size(504, 512);
  board = loadImage("board.png");
  spare = board.copy();
  save = board.copy();
  size = 26;
    coord = new PVector(row*58 + 77, 31);  //    for each row in int rows[] 
  done = false;
}

void draw(){
  if(coord.y <= 40)row = mouseX/58 -1;
  if(mouseX >= 77 && mouseX <= 77 + 58*6)coord.x = row*58 + 77;
  for(int i = 0; i < 6; i++) holes[i] = new PVector(row*58 + 77, 146 + 58*i); // <- in the actual version there would be one of these arrays
  println(row);
  image(board, 0, 0);
  //circle(77, 146, 45);
  board.loadPixels();
  if(coord.y < 436 && start == 1) coord.y += (coord.y-30)/15; //if within hole is false or y < 110
  else if(coord.y > 436) coord.y = 436;
  for(int y = 0; y < board.height; y++){                        //do all this once per row, and probably split up some of the stuff into functions (for code readability)
    for(int x = 0; x < board.width; x++){
      
      boolean withinHoles = false;
      for(int i = 0; i < 6; i++){
        if(sqrt((x-(holes[i].x))*(x-(holes[i].x)) + (y-(holes[i].y))*(y-(holes[i].y))) <= size){
          withinHoles = true;
        }
      }
      
      boolean withinCoord = false;
      if(sqrt((coord.x - x)*(coord.x - x) + (coord.y - y)*(coord.y - y)) <= size) withinCoord = true;  
      
      if((withinHoles || y < 108) && withinCoord){
        board.set(x, y, pieceColor);
        if(sqrt((x-(holes[5].x))*(x-(holes[5].x)) + (y-(holes[5].y))*(y-(holes[5].y))) <= size) save.set(x, y, board.get(x, y));
        //circle(x, y, 45);
      }
      else board.set(x, y, save.get(x, y));
      //else if (!(sqrt((x-(holes[5].x))*(x-(holes[5].x)) + (y-(holes[5].y))*(y-(holes[5].y))) <= size)) board.set(x, y, spare.get(x, y)); //better implementation to check for EACH hole in final product
      
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
  }
  else{
    board = spare.copy();
    save = spare.copy();
  }
  board.updatePixels();
  }
}
