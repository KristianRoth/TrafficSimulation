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

    ArrayList<Cell> getRoute() {
      ArrayList<Cell> startRoute = new ArrayList<Cell>();
      startRoute.add(start);
      return getRoute(startRoute);
    }

    ArrayList<Cell> getRoute(ArrayList<Cell> currentRoute) {
      Cell tail = currentRoute.get(currentRoute.size() - 1);


      if (tail == end) {
        println("Route Found");
        return currentRoute;
      }

      ArrayList<Cell> roads = tail.getRoads();

      return getNextRoutes(currentRoute, roads);
    }

    ArrayList<Cell> getNextRoutes(ArrayList<Cell> head, ArrayList<Cell> nextSteps) {
      println("nextSteps.size(): "+nextSteps.size());
      ArrayList<ArrayList<Cell>> routes = new ArrayList<ArrayList<Cell>>();
      for (Cell nextStep : nextSteps) {
        if (!head.contains(nextStep)) {
          ArrayList<Cell> copy = new ArrayList<Cell>(head);
          copy.add(nextStep);
          println("*******Start");
          println(head.size());
          println(copy.size());
          println("*******End");
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
          println(route.size() + " < " + minLength);
          if (route.size() < minLength) {
            minLength = route.size();
            min = route;
          }
        }
      }

      return min;
    }

}
