World world;
int sizeOfCell = 30;
int gridHeight;
int gridWidth;

void setup() {
	noLoop();
	size(1200, 600);
	gridHeight = height/sizeOfCell;
	gridWidth = width/sizeOfCell;


	world = new World();
	println("test");
	background(255);
	frameRate(60);
}


void draw() {
	background(255);
	int s = 0;
	while (true) {
		world = new World();
		if (world.isGood()) {
			break;
		}
		s++;	
	}
	println(s);

	world.draw();
	println(frameRate);
}

void keyPressed() {
	println("var: ");
	redraw();
	println("test");
}