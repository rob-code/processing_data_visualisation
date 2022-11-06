
class DataObject {

  String country;
  float value;

  DataObject(String country, float value) {
    this.country = country;
    this.value = value;
  }

  void setValue(float value) {
    this.value = value;
  }

  float getValue() {
    return this.value;
  }
}
