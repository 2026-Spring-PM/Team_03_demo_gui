# Team 03 GUI Demo

This is the mid-term demo build of our C++17 + SFML farm simulation game.

The demo repository contains only the executable, assets, run script, save file, and README.
Source files are not included in this repository.

# Run

## 1. Pull Docker Image

```bash
docker pull j00ny0un9/team_03_project:0.1.1
```

## 2. Run the Demo

### X11 Mode (Recommand using this if you can)

If your local environment supports X11 forwarding, you can run:

```bash
bash scripts/run.sh x11
```

or if you cloned this repository:

```bash
./scripts/run.sh x11
```

### VNC/noVNC Mode

This mode is recommended for macOS users  because it does not require local X11 setup.

```bash
bash scripts/run.sh vnc
```

or:

```bash
./scripts/run.sh vnc
```

After running the script, open the following address in your browser:

```text
http://localhost:6080/vnc.html
```

Then press the connect button on the noVNC page.
The SFML game window will appear inside the browser.


### Default Run

If no mode is given, the script runs in X11 mode by default.

```bash
bash scripts/run.sh
```

The script starts Docker and launches the SFML executable at `build/main`.

# Game System

## 1. GUI Controls

* WASD: Move
* F: Interact
* I: Inventory
* N: Next day
* F5: Save
* F9: Load
* Esc: Close panels/settings or open detail control descriptions

## 2. Farming

* Buy seeds from the shop.
* Hold a seed from the inventory.
* Till soil, plant crops, water crops, advance days, and harvest.
* Crop growth progresses when the day advances.
* We haven't finished the assets, so that's why the plants all look the same.

## 3. Shop

* Enter the shop building.
* Talk to the trader NPC.
* Buy seeds and purification items.
* Sell harvested crops.

## 4. Pollution System

* Soil, water, and air pollution are implemented.
* Soil pollution is shown on polluted ground areas.
* Water pollution is shown on water tiles.
* Air pollution affects the overall screen atmosphere.
* Soil and water can be purified with items.
* Air pollution is reduced through building air purifiers and installed filters.
* Pollution status is shown in the HUD.

## 5. Building Management

* Buildings can be upgraded.
* Building level affects management effects such as capacity and air purification power.
* Air filters can be installed into buildings.
* Installed filters are consumed when days advance.

## 6. Random Events

* Random pollution events can occur when advancing days.
* Events are shown in a separate event overlay.
* More events will be added..

## 7. Save / Load

* The game supports save/load.
* Player stats, inventory, crops, buildings, and pollution state are preserved.
* Press F5 to save.
* Press F9 to load.
* A prepared demo save is included at `saves/save.txt`, so you can load it to quickly test the demo features.


## 8. What will be added

- Storage
- Barn and livestock
- Casino mini-games
- Additional random events
- Crop quality details
- Price fluctuation
- More detailed interiors
- Final asset work
- Balance and bug fixes