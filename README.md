# Team 03 GUI Demo

This is the mid-term demo build of our C++17 + SFML farm simulation game.

The demo repository contains only the executable, assets, run script, and README.
Source files are not included in this repository.

# Run

## 1. Pull Docker Image
```bash
docker pull j00ny0un9/team_03_project:0.1.0
```
## 2. Run the Demo
```bash
bash scripts/run.sh
```
or if you cloned this repository:
```bash
./scripts/run.sh
```
The script starts Docker and launches the SFML executable at `build/main`.

# Game System

## 1. GUI Controls

- WASD: Move
- F: Interact
- I: Inventory
- N: Next day
- F5: Save
- F9: Load
- Esc: Close panels/settings or open detail control descriptions

## 2. Farming

- Buy seeds from the shop.
- Hold a seed from the inventory.
- Till soil, plant crops, water crops, advance days, and harvest.
- Crop growth progresses when the day advances.

## 3. Shop

- Enter the shop building.
- Talk to the trader NPC.
- Buy seeds and purification items.
- Sell harvested crops.

## 4. Pollution System

- Soil, water, and air pollution are implemented.
- Soil pollution is shown on polluted ground areas.
- Water pollution is shown on water tiles.
- Air pollution affects the overall screen atmosphere.
- Soil and water can be purified with items.
- Air pollution is reduced through building air purifiers and installed filters.
- Pollution status is shown in the HUD.

## 5. Building Management

- Buildings can be upgraded.
- Building level affects management effects such as capacity and air purification power.
- Air filters can be installed into buildings.
- Installed filters are consumed when days advance.

## 6. Random Events

- Random pollution events can occur when advancing days.
- Events are shown in a separate event overlay.

## 7. Save / Load

- The game supports save/load.
- Player stats, inventory, crops, buildings, and pollution state are preserved.
- Press F5 to save.
- Press F9 to load.
- A prepared demo save is included at `saves/save.txt`, so you can load it to quickly test the demo features.