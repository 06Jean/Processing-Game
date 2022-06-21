ArrayList<Integer> x  = new ArrayList<Integer>(),y = new ArrayList<Integer>();
int w=30, h=30, blocks=20, direction = 2, foodx =15, foody = 15, fc1 = 255, fc2 = 255, fc3 = 255, speed = 8;
// direction 0 = vers le bas, 1= vers le haut, 2 = droite, 3 = gauche
int[] x_direction={0,0,1,-1}, y_direction={1,-1,0,0}; //direction pour x et y
boolean gameover=false;

void keyPressed() {
  //les controls/directions
   int newdir=keyCode == DOWN? 0:(keyCode == UP?1:(keyCode == RIGHT?2:(keyCode == LEFT?3:-1)));
  if (newdir != -1) direction = newdir;
}
  
void setup(){
  size(600, 600);
  x.add(0); //position de debut
  y.add(15);
} 

void draw() {
  background(0); 
  fill(0, 255, 0);//colour du serpent
  for (int i = 0; i < x.size(); i++) rect(x.get(i)*blocks, y.get(i)*blocks, blocks, blocks);
  if (!gameover) {
    fill(fc1, fc2, fc3); //color nourriture
    ellipse(foodx*blocks+10, foody*blocks+10, blocks, blocks); //nourriture
    textAlign(LEFT);//score
    textSize(25);
    fill(255);
    text("Score: "+ x.size(), 10, 10, width -20, 50);
    if(frameCount%speed==0){
      x.add(0, x.get(0) + x_direction[direction]); //ajouter la longueur au serpent
      y.add(0, y.get(0) + y_direction[direction]);
    if (x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || y.get(0) >= h) gameover = true;
    for (int i = 1; i<x.size(); i++)//Game over si tu touch le serpent ou les coins de l'ecran
    if (x.get(0)==x.get(i)&&y.get(0)==y.get(i)) gameover=true; 
    if (x.get(0)==foodx && y.get(0)==foody) { //la nouvelle nourriture est generer si tu prends
         if (x.size() %5==0 && speed>=2) speed-=1;  // la vitesse augmente à chaque 5 points
        foodx = (int)random(0, w); //new food
        foody = (int)random(0, h);
        fc1 = (int)random(255); fc2 = (int)random(255); fc3 = (int)random(255); //nouvelle colour de nourriture
      } else {
      x.remove(x.size()-1);
      y.remove(y.size()-1);      
      }
    }
  } else{
    fill(219, 186, 18);
    textSize(30);
    textAlign(CENTER); // game over message
    text("GAME OVER \n Your SCORE is:"+ x.size() + "\n Press ENTER", width/2, height/3);
    if(keyCode == ENTER) { //ENTER pour continuer
    x.clear();
    y.clear();
    x.add(0);
    y.add(15);
    direction = 2;
    speed = 8;
    gameover = false;//reset
    }
  }
}