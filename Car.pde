class Car {
    World world;
    Cell[][] cells;
    Cell[] cities;
    ArrayList<Cell> junctions;
    Cell start;
    Cell end;
    ArrayList<Cell> route;
    float x, y;
    float vel = 1.3;

    boolean arrived = false;

    Car(World world) {
      this.world = world;
      this.cells = world.getCells();
      this.cities = world.getCities();
      this.junctions = world.getJunctions();

      start = cities[floor(random(cities.length))];
      do {
        end = cities[floor(random(cities.length))];
      } while(end == start);

      route = getRoute();
      x = start.x*sizeOfCell + sizeOfCell/2 + 2*sizeOfCell/18;
      y = start.y*sizeOfCell + sizeOfCell/2;


    }

    boolean arrived() {
      return arrived;
    }

    void draw() {
      fill(0, 0, 255);
      stroke(255, 0, 0);
      strokeWeight(2);
      ellipse(x, y, sizeOfCell/16, sizeOfCell/16);
    }

    void update() {
      if (route.size() == 1) {
        arrived = true;
        return;
      }
      Cell currentCell = route.get(0);
      Cell nextCell = route.get(1);
      x += (nextCell.x - currentCell.x)*vel;
      y += (nextCell.y - currentCell.y)*vel;
      float[] subPos = getSubPos();
      if (abs(subPos[0]) > sizeOfCell || abs(subPos[1]) > sizeOfCell) {
        route.remove(currentCell);

      }
    }

    float[] getSubPos() {
      Cell currentCell = route.get(0);
      return new float[]{x - currentCell.x*sizeOfCell - sizeOfCell/2, y - currentCell.y*sizeOfCell - sizeOfCell/2};
    }

    ArrayList<Cell> getRoute() {
      ArrayList<Cell> startRoute = new ArrayList<Cell>();
      startRoute.add(start);
      return getRoute(startRoute);
    }

    ArrayList<Cell> getRoute(ArrayList<Cell> currentRoute) {
      Cell tail = currentRoute.get(currentRoute.size() - 1);


      if (tail == end) {
        return currentRoute;
      }

      ArrayList<Cell> roads = tail.getRoads();

      return getNextRoutes(currentRoute, roads);
    }

    ArrayList<Cell> getNextRoutes(ArrayList<Cell> head, ArrayList<Cell> nextSteps) {
      ArrayList<ArrayList<Cell>> routes = new ArrayList<ArrayList<Cell>>();
      for (Cell nextStep : nextSteps) {
        if (!head.contains(nextStep)) {
          ArrayList<Cell> copy = new ArrayList<Cell>(head);
          copy.add(nextStep);
          routes.add(getRoute(copy));
        }
      }

      return minRoute(routes);
    }

    ArrayList<Cell> minRoute(ArrayList<ArrayList<Cell>> routes) {
      int minLength = Integer.MAX_VALUE;
      ArrayList<Cell> min = null;
      for (ArrayList<Cell> route : routes) {
        if (route != null) {
          if (route.size() < minLength) {
            minLength = route.size();
            min = route;
          }
        }
      }

      return min;
    }

}
