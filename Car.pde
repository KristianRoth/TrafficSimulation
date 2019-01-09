int sign(float x) {
  if (x > 0) {
    return 1;
  } else if (x < 0) {
    return -1;
  }
  return 0;
}


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


    boolean turned = true;
    Cell previousCell;

    boolean arrived = false;
    boolean started = false;

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

      float nextdx = sign(route.get(0).x - route.get(1).x);
      float nextdy = sign(route.get(0).y - route.get(1).y);

      x = start.x*sizeOfCell + sizeOfCell/2 + nextdy*sizeOfCell/6;
      y = start.y*sizeOfCell + sizeOfCell/2 - nextdx*sizeOfCell/6;
      previousCell = route.get(0);

    }

    boolean arrived() {
      return arrived;
    }

    void draw() {
      fill(255, 0, 0);

      noStroke();
      ellipse(x, y, sizeOfCell/6, sizeOfCell/6);
    }

    void update() {
      if (route.size() == 1) {
        arrived = true;
        return;
      }

      move();
    }

    void move() {

      Cell currentCell = route.get(0);
      Cell nextCell = route.get(1);

      float nextdx = (nextCell.x - currentCell.x)*vel;
      float nextdy = (nextCell.y - currentCell.y)*vel;

      float prevdx = (currentCell.x - previousCell.x)*vel;
      float prevdy = (currentCell.y - previousCell.y)*vel;
      float dx;
      float dy;
      if (turned) {
        dx = nextdx;
        dy = nextdy;
      } else {
        dx = prevdx;
        dy = prevdy;
      }

      if (checkForCollision(dx, dy)) {
        println("collided");
        return;
      }

      println("noCollision");

      started = true;

      x += dx;
      y += dy;

      float turnx = 0;
      float turny = 0;

      float[] subPos = getSubPos();

      if (sign(nextdx) != 0) {
        turnx = subPos[0];
        turny = sign(nextdx)*sizeOfCell/6;
      }

      if (sign(nextdy) != 0) {
        turnx = -sign(nextdy)*sizeOfCell/6;
        turny = subPos[1];
      }

      if (abs(subPos[0]-turnx) < vel/2 && abs(subPos[1]-turny) < vel/2) {
        setSubPos(turnx, turny);
        turned = true;
      }

      if (abs(subPos[0]) > sizeOfCell/2 || abs(subPos[1]) > sizeOfCell/2) {
        turned = false;
        previousCell = currentCell;
        route.remove(currentCell);

      }
    }

    float[] getSubPos() {
      Cell currentCell = route.get(0);
      return new float[]{x - currentCell.x*sizeOfCell - sizeOfCell/2, y - currentCell.y*sizeOfCell - sizeOfCell/2};
    }

    void setSubPos(float subx, float suby) {
      x = route.get(0).x*sizeOfCell + sizeOfCell/2 + subx;
      y = route.get(0).y*sizeOfCell + sizeOfCell/2 + suby;
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

    boolean checkForCollision(float dx, float dy) {
      float newx = x + dx;
      float newy = y + dy;

      for (Car car : world.cars) {
        if (car == this) {
          continue;
        }
        if (distance(car, newx, newy) < sizeOfCell/6.0 && car.started) {
          return true;
        }
      }
      return false;
    }

    float distance(Car car, float x, float y) {
      return sqrt(pow((car.x - x),2) + pow((car.y - y), 2));
    }

}
