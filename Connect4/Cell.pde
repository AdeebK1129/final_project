public class Cell {
  private int row;
  private int column;
  private boolean occupied;
  private int cellColor;

  public Cell(int row, int column) {
    this.row = row;
    this.column = column;
    this.occupied = false;
  }
  
  public Cell(int row, int column, int cellColor) {
    this.row = row;
    this.column = column;
    this.cellColor = cellColor;
    this.occupied = true;
  }

  public boolean isOccupied() {
    return occupied;
  }

  public void setOccupied(boolean occupied) {
    this.occupied = occupied;
  }
  
  public int getCellColor(){
    return cellColor;
  }
  
  public void setCellColor(int cellColor){
    this.cellColor = cellColor;
  }
}
