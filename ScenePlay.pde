// this class defines a "Play" scene
class ScenePlay {

  ArrayList<Enemy> enemies = new ArrayList();
  ArrayList<Flain> flains = new ArrayList();
  ArrayList<Evi> evis = new ArrayList();
  ArrayList<Fion> fions = new ArrayList();
  ArrayList<Bullet> bullets = new ArrayList();
  ArrayList<Sword> slashes = new ArrayList();
  ArrayList<Ice> shards = new ArrayList();
  ArrayList<Fire> flames = new ArrayList();
  ArrayList<Electric> sparks = new ArrayList();
  ArrayList<IceShard> iShards = new ArrayList();
  ArrayList<FireShard> fShards = new ArrayList();
  ArrayList<ElectricShard> eShards = new ArrayList();
  ArrayList<Ultimate> ultimates = new ArrayList();
  int aEnemies = 0;
  float counter = 0;
  float timer = 0;
  float enemieType;
  int max = 0; 
  float iCSpawnChance;
  int iCSpawn;
  float ultTimer = 0;


  Player player;

  PImage backgroundImage;
  PImage eC; //ElementalCrystal
  PImage eCEmpty; //ElementalCrystalEmpty
  PImage eCI; //ElementalCrystal, Ice
  PImage eCIE; //ElementalCrystal, Ice and Electric
  PImage eCE; //ElementalCrystal, Electric
  PImage eCEF; //ElementalCrystal, Electric and Fire
  PImage eCF; //ElementalCrystal, Fire
  PImage eCFI; //ElementalCrystal, Fire and Ice

  ScenePlay() {

    //Assign pictures to images
    backgroundImage = loadImage("GR Background.png");
    eC = loadImage("ElementalCrystal.png");
    eCEmpty = loadImage("ElementalCrystalEmpty.png");
    eCI = loadImage("ElementalCrystal, Ice.png");
    eCIE = loadImage("ElementalCrystal, Ice and Electric.png");
    eCE = loadImage("ElementalCrystal, Electric.png");
    eCEF = loadImage("ElementalCrystal, Electric and Fire.png");
    eCF = loadImage("ElementalCrystal, Fire.png");
    eCFI = loadImage("ElementalCrystal, Fire and Ice.png");


    player = new Player(); //Makes a plater
  }
  void update() {   
    // ----- SPAWN OBJECTS UNDER THIS LINE -----

    //SWORD
    if (currentWeapon == 0) {
      if (leftMouse == true && !prevLeftPressed) {
        Sword slash = new Sword(player.x, player.y, player.angle);
        slashes.add(slash);
      }
    }
    //ICE
    else if (currentWeapon == 1) {      
      if (leftMouse == true && !prevLeftPressed) {
        Ice shard = new Ice(player.x, player.y, player.angle);
        shards.add(shard);
      }
    }
    //FIRE
    else if (currentWeapon == 2) {
      if (leftMouse == true && !prevLeftPressed) {
        Fire flame = new Fire(player.x, player.y, player.angle);
        flames.add(flame);
      }
    }
    //ELECTRIC  
    else if (currentWeapon == 3) {
      if (leftMouse == true && !prevLeftPressed) {
        Electric spark = new Electric(player.x, player.y, player.angle);
        sparks.add(spark);
      }
    }
    //GUN(ADMIN)
    else if (currentWeapon == 4) {
      if (leftMouse == true && !prevLeftPressed) {
        for (int i = 0; i < 7; i++) {
          Bullet b = new Bullet(player.x, player.y, player.angle);
          bullets.add(b);
        }
      }
    }

    //ULT
    ultTimer += 1 * dt;
    if (ultTimer >= 3 && ultimates.size() > 0) ultimates.remove(0);
    if (player.hasUlt == true && spacePressed == true && prevSpacePressed == false) {
      Ultimate Ult = new Ultimate(player.x, player.y, player.angle);
      ultimates.add(Ult);
      ultTimer = 0;
      player.hasUlt = false;
    }



    timer += 1 * dt;
    if (timer > 0 && timer < 5) {
      max = 1;
    } else if (timer > 5 && timer < 10) {
      max = 2;
    } else if (timer > 10 && timer < 15) {
      max = 3;
    } else {
      max = 4;
    }


    counter += 1 * dt;
    if (counter >= .5) {
      counter = 0;
      aEnemies++;
      enemieType = random(0, max);
      if (enemieType < 1 && enemieType >= 0) {
        Enemy e = new Enemy();
        enemies.add(e);
      } else if (enemieType < 2 && enemieType >= 1) {
        Flain f = new Flain();
        flains.add(f);
      } else if (enemieType < 3 && enemieType >= 2) {
        Evi e = new Evi();
        evis.add(e);
      } else if (enemieType < 4 && enemieType >= 3) {
        Fion f = new Fion();
        fions.add(f);
      }
    }

    // ----- DO NOT SPAWN AFTER THIS LINE -----

    // ----- UPDATE ALL OBJECTS UNDER THIS LINE ----- 

    // ITERATE THROUGH ALL ENEMIES PRESENT IN THE ENEMYS ARRAYLIST
    for (int i = 0; i < enemies.size(); i++) //BASIC ENEMIES
    {
      // GET EACH ENEMY...
      Enemy e = enemies.get(i);
      // AND UPDATE THE ENEMY...
      e.update();

      if (checkCollisionPlayerEnemy(player, e)) {
        // COLLISION IS HAPPENING

        // Do something negitive
        player.health--;
        score--;
        println(player.health);

        // Kill the enemy    
        e.isDead = true;
      }

      for (int j = 0; j < bullets.size(); j++)//GUN(ADMIN) COLLISION
      {
        if (isCollidingWithBullet(e, bullets.get(j))) {
          e.isDead = true; 
          bullets.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < slashes.size(); j++)//SWORD COLLISION
      {
        if (isCollidingWithSlash(e, slashes.get(j))) {
          e.health -= 50;
        }
      }
      for (int j = 0; j < shards.size(); j++)//ICE COLLISION
      {
        if (isCollidingWithIce(e, shards.get(j))) {
          e.health -= 100;
          e.slowed = true;
          shards.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < flames.size(); j++)//FIRE COLLISION
      {
        if (isCollidingWithFire(e, flames.get(j))) {
          e.health -= 100;
          e.burned = true;
          flames.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < sparks.size(); j++)//ELECTRIC COLLISION
      {
        if (isCollidingWithElectric(e, sparks.get(j))) {
          e.health -= 100;
          e.stuned = true;
          sparks.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < ultimates.size(); j++)//ULT COLLISION
      {
        if (isCollidingWithUltimate(e, ultimates.get(j))) {
          e.health -= 50;
          e.stuned = true;
          e.slowed = true;
          e.burned = true;
          //score++;
        }
      }

      //KILL ENEMY?
      if (e.gotPass == true) {
        player.health -= 1;
        enemies.remove(i);
      }

      if (e.isDead == true) {
        score++;
        enemies.remove(i);
      }
    }

    // FLAIN

    for (int i = 0; i < flains.size(); i++)
    {
      // GET EACH ENEMY...
      Flain f = flains.get(i);
      // AND UPDATE THE ENEMY...
      f.update();

      if (checkCollisionPlayerFlain(player, f)) {
        // COLLISION IS HAPPENING

        // Do something negitive
        player.health -= 2;
        score--;
        println(player.health);

        // Kill the enemy    
        f.isDead = true;
      }

      for (int j = 0; j < bullets.size(); j++)//GUN(ADMIN) COLLISION
      {
        if (FlainCollidingWithBullet(f, bullets.get(j))) {
          f.isDead = true; 
          bullets.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < slashes.size(); j++)//GUN(ADMIN) COLLISION
      {
        if (FlainCollidingWithSlash(f, slashes.get(j))) {
          f.health -= 50;
        }
      }
      for (int j = 0; j < shards.size(); j++)//ICE COLLISION
      {
        if (FlainCollidingWithIce(f, shards.get(j))) {
          f.health -= 100;
          f.slowed = true;
          shards.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < flames.size(); j++)//FIRE COLLISION
      {
        if (FlainCollidingWithFire(f, flames.get(j))) {
          f.health -= 100;
          flames.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < sparks.size(); j++)//ELECTRIC COLLISION
      {
        if (FlainCollidingWithElectric(f, sparks.get(j))) {
          f.health -= 100;
          f.stuned = true;
          sparks.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < ultimates.size(); j++)//ULT COLLISION
      {
        if (FlainCollidingWithUltimate(f, ultimates.get(j))) {
          f.health -= 50;
          f.stuned = true;
          f.slowed = true;
          //score++;
        }
      }

      //KILL ENEMY?
      if (f.gotPass == true) {
        player.health -= 2;
        flains.remove(i);
      }

      if (f.isDead == true) {
        score++;
        //FIRESHARD
        if (f.x >= 25 && f.x <= 775 && f.y >= 50) {
          if (fShards.size() < 1 && player.hasFireCrystal == false) {
            if (random(0, 5) <= 1) {
              //Spawn class at cords of enemy          
              FireShard fShard = new FireShard(f.x - f.radius, f.y - f.radius);
              fShards.add(fShard);
              fShard.isDropped = true;
            }
          } else
          {
            for (int j = 0; j < fShards.size(); j++) {
              FireShard fS = fShards.get(j);
              if (fS.isDropped == false && player.hasFireCrystal == false) {
                if (random(0, 5) <= 1) {
                  //Spawn class at cords of enemy          
                  FireShard fShard = new FireShard(f.x - f.radius, f.y - f.radius);
                  fShards.add(fShard);
                  fShard.isDropped = true;
                }
              }
            }
          }
        }
        flains.remove(i);
      }
    }

    // EVI

    for (int i = 0; i < evis.size(); i++) //BASIC ENEMIES
    {
      // GET EACH ENEMY...
      Evi e = evis.get(i);
      // AND UPDATE THE ENEMY...
      e.update();

      if (checkCollisionPlayerEvi(player, e)) {
        // COLLISION IS HAPPENING

        // Do something negitive
        player.health--;
        score--;
        println(player.health);

        // Kill the enemy    
        e.isDead = true;
      }

      for (int j = 0; j < bullets.size(); j++)//GUN(ADMIN) COLLISION
      {
        if (EviCollidingWithBullet(e, bullets.get(j))) {
          e.isDead = true; 
          bullets.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < slashes.size(); j++)//SWORD COLLISION
      {
        if (EviCollidingWithSlash(e, slashes.get(j))) {
          e.health -= 50;
        }
      }
      for (int j = 0; j < shards.size(); j++)//ICE COLLISION
      {
        if (EviCollidingWithIce(e, shards.get(j))) {
          e.health -= 100;
          e.slowed = true;
          shards.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < flames.size(); j++)//FIRE COLLISION
      {
        if (EviCollidingWithFire(e, flames.get(j))) {
          e.health -= 100;
          e.burned = true;
          flames.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < sparks.size(); j++)//ELECTRIC COLLISION
      {
        if (EviCollidingWithElectric(e, sparks.get(j))) {
          e.health -= 100;
          sparks.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < ultimates.size(); j++)//ULT COLLISION
      {
        if (EviCollidingWithUltimate(e, ultimates.get(j))) {
          e.health -= 50;
          e.slowed = true;
          e.burned = true;
          //score++;
        }
      }

      //KILL ENEMY?
      if (e.gotPass == true) {
        player.health -= 1;
        evis.remove(i);
      }

      if (e.isDead == true) {
        score++;
        //ELECTRICSHARD
        if (e.x >= 25 && e.x <= 775 && e.y >= 50) {
          if (eShards.size() < 1 && player.hasElectricCrystal == false) {
            if (random(0, 5) <= 1) {
              //Spawn class at cords of enemy          
              ElectricShard eShard = new ElectricShard(e.x - e.radius, e.y - e.radius);
              eShards.add(eShard);
              eShard.isDropped = true;
            }
          } else
          {
            for (int j = 0; j < eShards.size(); j++) {

              ElectricShard eS = eShards.get(j);
              if (eS.isDropped == false && player.hasElectricCrystal == false) {
                if (random(0, 5) <= 1) {
                  //Spawn class at cords of enemy          
                  ElectricShard eShard = new ElectricShard(e.x - e.radius, e.y - e.radius);
                  eShards.add(eShard);
                  eShard.isDropped = true;
                }
              }
            }
          }
        }
        evis.remove(i);
      }
    }

    // FION

    for (int i = 0; i < fions.size(); i++) //BASIC ENEMIES
    {
      // GET EACH ENEMY...
      Fion f = fions.get(i);
      // AND UPDATE THE ENEMY...
      f.update();

      if (checkCollisionPlayerFion(player, f)) {
        // COLLISION IS HAPPENING

        // Do something negitive
        player.health--;
        score--;
        println(player.health);

        // Kill the enemy    
        f.isDead = true;
      }

      for (int j = 0; j < bullets.size(); j++)//GUN(ADMIN) COLLISION
      {
        if (FionCollidingWithBullet(f, bullets.get(j))) {
          f.isDead = true; 
          bullets.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < slashes.size(); j++)//SWORD COLLISION
      {
        if (FionCollidingWithSlash(f, slashes.get(j))) {
          f.health -= 50;
          //score++;
        }
      }
      for (int j = 0; j < shards.size(); j++)//ICE COLLISION
      {
        if (FionCollidingWithIce(f, shards.get(j))) {
          f.health -= 100;
          shards.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < flames.size(); j++)//FIRE COLLISION
      {
        if (FionCollidingWithFire(f, flames.get(j))) {
          f.health -= 100;
          f.burned = true;
          flames.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < sparks.size(); j++)//ELECTRIC COLLISION
      {
        if (FionCollidingWithElectric(f, sparks.get(j))) {
          f.health -= 100;
          f.stuned = true;
          sparks.get(j).isDead = true;
          //score++;
        }
      }
      for (int j = 0; j < ultimates.size(); j++)//ULT COLLISION
      {
        if (FionCollidingWithUltimate(f, ultimates.get(j))) {
          f.health -= 50;
          f.stuned = true;
          f.burned = true;
          //score++;
        }
      }

      //KILL ENEMY?
      if (f.gotPass == true) {
        player.health -= 1;
        fions.remove(i);
      }

      if (f.isDead == true) {
        score++; 
        //ICESHARD
        if (f.x >= 25 && f.x <= 775 && f.y >= 50) { 
          if (iShards.size() < 1 && player.hasIceCrystal == false) {
            if (random(0, 5) <= 1) {
              //Spawn class at cords of enemy          
              IceShard iShard = new IceShard(f.x - f.radius, f.y - f.radius);
              iShards.add(iShard);
              iShard.isDropped = true;
            }
          } else
          {
            for (int j = 0; j < iShards.size(); j++)
            {
              IceShard iS = iShards.get(j);
              if (iS.isDropped == false && player.hasIceCrystal == false) {
                if (random(0, 5) <= 1) {
                  //Spawn class at cords of enemy          
                  IceShard iShard = new IceShard(f.x - f.radius, f.y - f.radius);
                  iShards.add(iShard);
                  iShard.isDropped = true;
                }
              }
            }
          }
        }
        fions.remove(i);
      }
    }

    for (int i = 0; i < bullets.size(); i++) // GUN(ADMIN)
    {
      Bullet b = bullets.get(i);

      b.update();
      if (b.isDead == true) bullets.remove(i);
    }
    for (int i = 0; i < slashes.size(); i++) // SWORD
    {
      Sword slash = slashes.get(i);

      slash.update();
      if (slash.isDead == true) slashes.remove(i);
    }
    for (int i = 0; i < shards.size(); i++) // Ice
    {
      Ice shard = shards.get(i);

      shard.update();
      if (shard.isDead == true) shards.remove(i);
    }
    for (int i = 0; i < flames.size(); i++) // Fire
    {
      Fire flame = flames.get(i);

      flame.update();
      if (flame.isDead == true) flames.remove(i);
    }
    for (int i = 0; i < sparks.size(); i++) // Electric
    {
      Electric spark = sparks.get(i);

      spark.update();
      if (spark.isDead == true) sparks.remove(i);
    }
    for (int i = 0; i < ultimates.size(); i++) // ULT
    {
      Ultimate ult = ultimates.get(i);

      ult.update();
      if (ult.isDead == true) ultimates.remove(i);
    }

    for (int i = 0; i < iShards.size(); i++) // ICESHARD
    {
      IceShard iS = iShards.get(i);

      if (checkCollisionPlayerIceShard(player, iS)) {
        iS.playerOn = true;
        player.hasIceCrystal = true;
      }

      iS.update();
      if (iS.isDropped == false) iShards.remove(i);
    }

    for (int i = 0; i < fShards.size(); i++) // FIRESHARD
    {
      FireShard fS = fShards.get(i);

      if (checkCollisionPlayerFireShard(player, fS)) {
        fS.playerOn = true;
        player.hasFireCrystal = true;
      }

      fS.update();

      if (fS.isDropped == false) fShards.remove(i);
    }    

    for (int i = 0; i < eShards.size(); i++) // ELECTRICSHARD
    {
      ElectricShard eS = eShards.get(i);

      if (checkCollisionPlayerElectricShard(player, eS)) {
        eS.playerOn = true;
        player.hasElectricCrystal = true;
      }

      eS.update();
      if (eS.isDropped == false) eShards.remove(i);
    }    


    player.update();// Update Player

    if (shiftPressed == true && !prevShiftPressed)// Weapon Switch
    {
      if (currentWeapon < 3) {
        currentWeapon++;
      } else {
        currentWeapon = 0;
      }
    }





    // ----- DO NOT UPDATE ANYTHING AFTER THIS LINE



    // ----- PREP FOR NEXT FRAME AFTER THIS LINE

    prevLeftPressed = leftMouse;
    prevShiftPressed = shiftPressed;
    prevSpacePressed = spacePressed;
  }

  void draw() {
    // ----- DRAW ALL OBJECTS UNDER THIS LINE -----

    image(backgroundImage, 0, 0);
    fill(255);
    textSize(30);
    textAlign(CENTER, TOP);
    text(score, width/2, 20);
    textAlign(RIGHT, BOTTOM);
    text("Player Health: " + player.health, 800, 970);
    textAlign(LEFT, BOTTOM);
    text("Weapon class: " + currentWeapon, 0, 970);    
    if ((player.hasIceCrystal == true && player.hasFireCrystal == true && player.hasElectricCrystal == true) || player.hasUlt == true)
    {
      image(eC, 350, 900);
    } else if (player.hasIceCrystal == true && player.hasFireCrystal == false && player.hasElectricCrystal == false)
    {
      image(eCI, 350, 900);
    } else if (player.hasIceCrystal == false && player.hasFireCrystal == true && player.hasElectricCrystal == false)
    {
      image(eCF, 350, 900);
    } else if (player.hasIceCrystal == false && player.hasFireCrystal == false && player.hasElectricCrystal == true)
    {
      image(eCE, 350, 900);
    } else if (player.hasIceCrystal == true && player.hasFireCrystal == true && player.hasElectricCrystal == false)
    {
      image(eCFI, 350, 900);
    } else if (player.hasIceCrystal == true && player.hasFireCrystal == false && player.hasElectricCrystal == true)
    {
      image(eCIE, 350, 900);
    } else if (player.hasIceCrystal == false && player.hasFireCrystal == true && player.hasElectricCrystal == true)
    {
      image(eCEF, 350, 900);
    } else if (player.hasIceCrystal == false && player.hasFireCrystal == false && player.hasElectricCrystal == false)
    {
      image(eCEmpty, 350, 900);
    }

    // ITERATE THROUGH ALL ENEMIES PRESENT IN THE ENEMYS ARRAYLIST

    for (int i = 0; i < enemies.size(); i++)//ENEMIES
    {
      // GET EACH ENEMY...
      Enemy e = enemies.get(i);
      // AND UPDATE THE ENEMY...
      e.draw();
    }

    //FLAIN

    for (int i = 0; i < flains.size(); i++)//FLAIN
    {
      // GET EACH ENEMY...
      Flain f = flains.get(i);
      // AND UPDATE THE ENEMY...
      f.draw();
    }

    //EVI

    for (int i = 0; i < evis.size(); i++)//EVI
    {
      // GET EACH ENEMY...
      Evi e = evis.get(i);
      // AND UPDATE THE ENEMY...
      e.draw();
    }

    //FION

    for (int i = 0; i < fions.size(); i++)//FION
    {
      // GET EACH ENEMY...
      Fion f = fions.get(i);
      // AND UPDATE THE ENEMY...
      f.draw();
    }

    player.draw(); // PLAYER DRAW

    for (int i = 0; i < bullets.size(); i++)//GUN(ADMIN)
    {
      Bullet ben = bullets.get(i);

      ben.draw();
    }
    for (int i = 0; i < slashes.size(); i++)//GUN(ADMIN)
    {
      Sword slash = slashes.get(i);

      slash.draw();
    }
    for (int i = 0; i < shards.size(); i++)//ICE
    {
      Ice shard = shards.get(i);

      shard.draw();
    }
    for (int i = 0; i < flames.size(); i++)//FIRE
    {
      Fire flame = flames.get(i);

      flame.draw();
    }
    for (int i = 0; i < sparks.size(); i++)//ELECTRIC
    {
      Electric spark = sparks.get(i);

      spark.draw();
    }
    for (int i = 0; i < ultimates.size(); i++)//ULT
    {
      Ultimate ult = ultimates.get(i);

      ult.draw();
    }
    for (int i = 0; i < iShards.size(); i++)// ICESHARDS
    {
      IceShard iS = iShards.get(i);

      iS.draw();
    }
    for (int i = 0; i < fShards.size(); i++)// FIRESHARDS
    {
      FireShard fS = fShards.get(i);

      fS.draw();
    }
    for (int i = 0; i < eShards.size(); i++)// ELECTRICSHARDS
    {
      ElectricShard eS = eShards.get(i);

      eS.draw();
    }
  }

  // ----- DO NOT DRAW ANYTHING AFTER THIS LINE
}
