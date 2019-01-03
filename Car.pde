class Car {
    World world;
    Cell[][] cells;
    Cell[] cities;
    ArrayList<Cell> junctions;
    Cell start;
    Cell end;
    Cell[] route;

    Car(World world) {
      println("Init Car");
      this.world = world;
      this.cells = world.getCells();
      this.cities = world.getCities();
      this.junctions = world.getJunctions();

      start = cities[floor(random(cities.length))];
      end = cities[floor(random(cities.length))];

      start.highlite(true);
      end.highlite(true);

      println(start);
      println(end);


    }


    ArrayList<Cell> getRoute(ArrayList<Cell> currentRoute) {
      Cell tail = currentRoute[currentRoute.length];
      boolean[] = tail.getRoads();

      return null;
    }

}
