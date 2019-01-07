World world;
int sizeOfCell = 30;
int gridHeight;
int gridWidth;

void setup() {
	size(1200, 600);
	gridHeight = height/sizeOfCell;
	gridWidth = width/sizeOfCell;

  rebase();

	background(255);
	frameRate(60);
}


void draw() {
	background(255);
  for(int i = 0; i < 1; i++) {
    world.update();
  }
	world.draw();
}

void rebase() {
  while (true) {
    world = new World();
    if (world.isGood()) {
      break;
    }
  }

	world = new World();
}

void keyPressed() {
	rebase();
}
