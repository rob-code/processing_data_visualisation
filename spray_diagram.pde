class SprayDiagram {

  int x, y;
  String title;
  ArrayList <DataObject>data = new ArrayList<DataObject>();


  float value;
  int n;
  float delta;
  float r;
  float theta;
  int scale_factor = 100;


  //must parameterise data in the constructor or it wont work, without this we only get an object
  SprayDiagram(int x, int y, String title, ArrayList <DataObject> data) {

    this.x = x;
    this.y = y;
    this.title = title;
    this.data = data;

    textSize(20);
    textAlign(CENTER);
    fill(190);
    text(title, x, y + 120);

    stroke(230);
    strokeWeight(2);

    n = data.size();
    delta = TWO_PI/n;
    theta = 0;

    textSize(14);
    textAlign(CENTER);
    fill(190);
    text(data.get(0).country, x + 60, y-10);


    for (int i = 0; i < n; i++) {
      r = (data.get(i).value/data.get(1).value)* scale_factor;
      line(x, y, x + (r * cos(theta)), y + (r * sin(theta)));
      theta += delta;
    }

    stroke(230);
    strokeWeight(.1);
    fill(0);

    ellipse(x, y, 8, 8);
  }
}
