This mod allows you to use some of Valkyrien Skies's API in your MCreator mod.

## What it adds

**New procedures:**

- Get a VS ship from a block
- Apply forces to VS ships
- Teleport ships
- Get and set various properties of ships (Slug, velocity, etc)
- Iterate over all ships in dimension
- Store custom data values (text, logic, and numbers supported) per-ship
- Transform position and rotations to and from ship-space

**New variable types:**

It adds the ship variable type, which can be gotten from a block position and used in procedures

**Global triggers:**

Currently, only the Valkyrien Skies "ship loaded" event is supported, but more to come in future!

**Templates:**

This plugin comes with several procedure templates, which can help you explore the possibilities of the Valkyrien Skies based procedures.

**Note: the templates are all designed to work with the "player right clicks block" trigger. They haven't been tested with any other triggers.**

## How to install it

Due to the complexity of Valkyrien Skies, this plugin is slightly tricky to setup. Just make sure to follow these instructions closely.

1. **Install my "Extra Types" plugin**, its variable types are required for the procedures. You can find it here: https://mcreator.net/plugin/114773/extra-types
2. **Install NerdyPuzzles "Forge Mixin" plugin**, its gradle changes are required for Valkyrien Skies to be able to run. You can find it here: https://mcreator.net/plugin/104607/forge-mixins-support
3. Add this plugin. **Make sure Java plugins are enabled** in plugin preferences!
4. **ENABLE THE API**. Find the "Valkyrien Skies" api in workspace settings, and make sure its enabled! **You may encounter build issues if it is disabled!**
5. **RE-OPEN YOUR WORKSPACE!** This step is EXTREMELY important. This plugin adds custom Java files to your mod to allow it to function, however on a workspace re-factor or a new workspace, these files will be removed! The plugin will re-add them on a workspace re-load.
6. Profit

**Note: the plugin currently only supports Forge 1.20.1! This also means it doesn't support MCreator 2025.x, since Forge 1.20.1 is no longer an available generator.**

## A noobs guide to Valkyrien Skies

Valkyrien Skies free-moving objects (blocks with physics) are called "Ships". Each ship is stored in a "shipyard". This means that its blocks are stored very far away, in a huge void. What you the player are seeing, is these blocks in the shipyard being "projected" into your view. Then when you interact with them, your interactions (breaking, placing blocks, etc) are "transformed" back into the shipyard to have an effect. This means that any blocks you have that are on a ship may have extremely large coordinates! To remedy this, you can use the "transform position" procedure block going from "ship -> world" (shipyard to the normal world) to move the position to where the ship visually is. Same applies for rotations, like the direction a block is facing.

## Potential issues

If you are encountering build issues with this plugin, make sure to check these things first.

The plugin custom-generates some Java files into `Source (gradle)/<mod_folder>/ships` and `Source (gradle)/<mod_folder>/mixin`. Make sure there are files in these locations! If some or all are missing, try re-loading the workspace. The plugin should re-generate them. Files that should exist:

`/ships`

- `ForceData.java`
- `ForceDirectionMode.java`
- `ForceInducedShips.java`
- `ForceMode.java`
- `OnShipLoad.java`
- `RotData.java`
- `TeleportHandler.java`

`/mixin`

- `ServerShipObjectWorldAccessor.java`

**These files will be deleted on workspace re-factor! Make sure to re-load your workspace after this happens so the files can be re-generated!**

If you have these files, but you are failing to build (with an error such as `org.valkyrienskies.<stuff>.Ship not found!`) make sure that the api is enabled in workspace settings!

If any procedure blocks are still failing to build, and you can't figure out why, leave a comment and I might be able to help. If any procedure blocks are **causing a crash**, please leave a comment! They should be made (by me) to be 100% crash free but I could have missed some issues.

## Removing the plugin

If for some reason you no longer wish to use this plugin, follow these steps:

1. Disable the API in workspace settings. **This should cause a workspace re-factor.**
2. After workspace re-factor, **some procedures may fail to build**. Simply go into each and delete any remaining Valkyrien Skies procedure blocks
3. Then remove the plugin from your plugin folder, or disable it. **Don't** re-open your workspace with the plugin still enabled! The re-factor when you disabled the API will have deleted the extra files mentioned above, but if you re-open your workspace with the plugin they will come back! **You may need to delete them manually**.