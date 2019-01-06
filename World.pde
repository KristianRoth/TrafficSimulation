class World {

	int numberOfCities = 10;
	int numberOfInitialJunctions = 3;
	int minDistJunctions = 2;
	int minJunctions = 3;

	Cell[][] cells = new Cell[gridWidth][gridHeight];

	Cell[] cities = new Cell[numberOfCities];
	ArrayList<Cell> junctions = new ArrayList<Cell>();

	PGraphics background;

	World() {

		for (int i = 0; i < cells.length; i++) {
			for (int j = 0; j < cells[i].length; ++j) {
				cells[i][j] = new Cell(cells, i, j);
			}
		}

		for (int i = 0; i < numberOfCities; i++) {
			Cell newCity;
			do {
				newCity = cells[floor(random(gridWidth))][floor(random(gridHeight))];
			} while(newCity.state == Cell.CITY);

			newCity.setCity();
			cities[i] = newCity;
		}

		for (int i = 0; i < numberOfInitialJunctions; i++) {
			Cell newJunction;
			do {
				newJunction = cells[floor(random(2, gridWidth-2))][floor(random(2, gridHeight-2))];
			} while(newJunction.state == Cell.JUNCTION);
			newJunction.setJunction();
			junctions.add(newJunction);
		}

		//Cell city1 = cities[floor(random(cities.length))]
		for (Cell city : cities) {
			Cell junction = closestJunction(city);
			if (random(1) > 0.5) {
				makeRoad(city, junction);
			} else {
				makeRoad(junction, city);
			}
		//	break;
		}

		for (int i = 0; i < junctions.size(); ++i) {
			for (int j = i+1; j < junctions.size(); ++j) {
				makeRoad(junctions.get(i), junctions.get(j));
			}
		}

		junctions = new ArrayList<Cell>();
		for (Cell[] rows : cells) {
			for (Cell cell : rows) {
				if (cell.isJunction()){
					junctions.add(cell);
				}
			}
		}

		background = getBack();
		// for (PVector junction : junctions)
	}

	boolean isGood() {
		if (junctions.size() <= minJunctions) {
			return false;
		}
		for (int i = 0; i < junctions.size(); ++i) {
			for (int j = i+1; j < junctions.size(); ++j) {
				if (distance(junctions.get(i), junctions.get(j)) <= minDistJunctions) {
					return false;
				}
			}
		}
		return true;
	}

	PGraphics getBack() {
		PGraphics bg = createGraphics(width, height);
		bg.beginDraw();
		bg.stroke(0);
		for (int i = sizeOfCell; i < height; i += sizeOfCell) {
			//bg.line(0, i, width, i);
		}

		for (int i = sizeOfCell; i < width; i += sizeOfCell) {
			//bg.line(i , 0, i, height);
		}

		for (Cell[] rows : cells) {
			for (Cell cell : rows) {
				cell.drawBackground(bg);
			}
		}
		bg.endDraw();
		return bg;
	}

	void draw() {
		image(background, 0, 0);

    for (Cell[] rows : cells) {
			for (Cell cell : rows) {
				cell.draw();
			}
		}

	}

  void update() {
    println("update world");
    Car car1 = new Car(this);
    for (Cell cell : car1.getRoute()) {
    	cell.highlite(255, 0, 0);
    }

    Car car2 = new Car(this);
    for (Cell cell : car2.getRoute()) {
    	cell.highlite(0, 255, 0);
    }

  }

	void makeRoad(Cell c1, Cell c2) {
		int minX = min(c1.x, c2.x);
		int maxX = max(c1.x, c2.x);
		boolean first = true;
		boolean last;
		for (int i = minX; i <= maxX; i++) {
			last = i == maxX;
			cells[i][c1.y].setRoad(new boolean[]{false, !first, !last, false});
			first = false;
		}

		int minY = min(c1.y, c2.y);
		int maxY = max(c1.y, c2.y);

		first = true;
		for (int i = minY; i <= maxY; i++) {
			last = i == maxY;
			cells[c2.x][i].setRoad(new boolean[]{!first, false, false, !last});
			first = false;
		}
	}

	Cell closestJunction(Cell cell) {
		int min = Integer.MAX_VALUE;
		Cell minJunction = null;
		for (Cell junction : junctions) {
			int dist = distance(cell, junction);
			if (dist < min) {
				min = dist;
				minJunction = junction;
			}
		}
		return minJunction;
	}

	int distance(Cell c1, Cell c2) {
		return abs(c1.x - c2.x) + abs(c1.y - c2.y);

	}

  Cell[][] getCells() {
    return cells;
  }

  Cell[] getCities() {
    return cities;
  }

  ArrayList<Cell> getJunctions() {
    return junctions;
  }
}
