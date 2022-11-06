
int x, y;
Table table;
String[] sectors = {"Biogas", "Coal Mines", "Oil & Gas", "Other (Non-GMI)"};
ArrayList<DataObject> data = new ArrayList<DataObject>();
int[][]xy;

void setup() {
  size(1200, 800);
  background(0);

  textSize(24);
  textAlign(CENTER);
  fill(190);
  text("Global Methane Emissions by Sector and Country", width/2, 60);
  table = loadTable("methane-data.csv", "header");

  xy = coordinateManager(sectors.length);
  
  for (int i = 0; i < sectors.length; i++) {
    SprayDiagram sprayDiagram = new SprayDiagram(xy[i][0], xy[i][1], sectors[i], diagramData(sectors[i]));
  }
}


int[][] coordinateManager(int n) {

  xy = new int[n][2];

  xy [0][0] = width/4;
  xy [0][1] = height/4;
  xy [1][0] = 3*width/4;
  xy [1][1] = height/4;
  xy [2][0] = width/4;
  xy [2][1] = 3*height/4;
  xy [3][0] = 3*width/4;
  xy [3][1] = 3*height/4;

  return xy;
}


ArrayList<DataObject> diagramData(String sector) {

  // create data array - but its much too big
  for (TableRow row : table.rows()) {
    int year = row.getInt("year");
    String category = row.getString("GMI Sector");
    if (year == 2022 && category.equals(sector)) {
      data.add(new DataObject(row.getString("country"), row.getFloat("value") ));
    }
  }

  //reduce the size of the data array to say the top 20 values, but keep the original array
  ArrayList<DataObject> dataToSort = data;
  ArrayList<DataObject> sortedData = new ArrayList<DataObject>();
  int number_of_data_points = 20;

  for (int n = 0; n < number_of_data_points; n++) {

    float highest_value = 0;
    int index_of_highest_value = 0;

    for (int i = 0; i < dataToSort.size(); i++) {
      if (data.get(i).value > highest_value) {
        highest_value = dataToSort.get(i).value;
        index_of_highest_value = i;
      }
    }
    sortedData.add(dataToSort.get(index_of_highest_value));
    dataToSort.remove(index_of_highest_value);
  }

  //Some countries appear twice in the array, these duplicates need to be removed and their values added
  ArrayList<DataObject> duplicatesRemovedData = new ArrayList<DataObject>();

  for (int i = 0; i < sortedData.size(); i++) {

    String name = sortedData.get(i).country;
    float value = sortedData.get(i).value;
    boolean duplicate = false;

    if (duplicatesRemovedData.size() == 0) {
      duplicatesRemovedData.add(sortedData.get(i));
    } else {

      for (int j = 0; j < duplicatesRemovedData.size(); j++) {

        if (name.equals(duplicatesRemovedData.get(j).country)) {
          duplicatesRemovedData.get(j).setValue(duplicatesRemovedData.get(j).value + value);
          duplicate = true;
        }
      }

      if (!duplicate) {
        duplicatesRemovedData.add(sortedData.get(i));
      }
    }
  }
  return duplicatesRemovedData;
}
