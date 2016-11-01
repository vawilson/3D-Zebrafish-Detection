Table table;
void createTable() {
  
  table = new Table();

  table.addColumn("X-Position");
  table.addColumn("Y-Position");
  table.addColumn("Z-Position");
  //records at what time durig the video the pos was
  table.addColumn("Time-Stamp");

  //name of the table you want to save, will be saved in the data tables folder
  saveTable(table, "data tables/" + inputname + ".csv");
  saveTable(table,"View3D/data/"+ inputname+".csv");
  
}

void updateTable(int x, int y, int z, Float time) {

  TableRow newRow = table.addRow();
  newRow.setInt("X-Position", x);
  newRow.setInt("Y-Position", y);
  newRow.setInt("Z-Position", z);
  newRow.setFloat("Time-Stamp", time);
    saveTable(table, "data tables/" + inputname + ".csv");
   saveTable(table,"View3D/data/"+ inputname+".csv");
}



