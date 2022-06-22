# Description
This Project aims to empower you in setting up your very own Server-Network using Docker, which can be started using `docker-compose up` inside this Directory.

I use this Repository to run my own Minecraft-Server at kB01.de.

**This Repository is currently in a Prototyping State!**




# Usage
Reqirements:
- git
- docker
- docker-compose

Clone this Repository
`git clone https://github.com/kB01guy/minecraft-server-kb01-de`

Navigate into Repository
`cd minecraft-server-kb01-de`

Start the Server-Network
`docker-compose up`

## Configuration

For my Use-Case Containerization is great to get the most Performance for each Universe (Survival, Creative, Lobby, Minigames).

Even though Minecraft supports Multiple Threads, the Main Game-Logic runs on a single Thread.
All Server Plugins, The Game Logic, and all Worlds are handled Single-Threaded.
Some Little Things are running on different Threads like the Chunk-Sending to Players.

If you just want run a Minecraft Server without different Worlds and not many Plugins, I strongly advice not to use my Project and instead only use https://github.com/itzg/docker-minecraft-server for creating your Server.

To further configure your Server-Network, see
https://github.com/itzg/docker-bungeecord for mc-bungeecord and
https://github.com/itzg/docker-minecraft-server for other Services

### Server Configuration
The Server Proxy (default: BungeeCord) supports Plugins as well as the Game-Servers them selves.
The Docker Containers allows automatic Plugin-Downloads from spigotmc.org via the Variable `SPIGET_RESOURCES`, which contains a Comma separated List of Plugin-IDs.

#### BungeeCord
This is the Proxy-Server that listens to the default Minecraft Port `25565` and then distribute the Players to the Game-Server they want to play on.

##### Plugin List

| Spigot ID | Price | Name                 | Description                                                                                                    | Links                                                                                                                |
|:---------:| ----- | -------------------- | -------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
|           | Free  | LuckPerms BungeeCord | Manages Permissions for BungeeCord Plugins                                                                     | [Github](https://github.com/lucko/LuckPerms) [luckperms.net](https://luckperms.net/download)                         |
| 241       | Free  | ServerListPlus       | Allows customization of your ServerList Info                                                                   | [Github](https://github.com/Minecrell/ServerListPlus) [Spigot](https://www.spigotmc.org/resources/241/)              |
| 8695      | Free  | AdvancedBan          | All-In-One Punishment-System                                                                                   | [Github](https://github.com/DevLeoko/AdvancedBan) [Spigot](https://www.spigotmc.org/resources/8695/)                 |
| 68956     | Free  | UltraStaffChat       | Allows Communication to the Server-Team, throughout the Network and even beyond thanks to Discord-Integration. | [Github](https://github.com/HyperaOfficial/UltraStaffChat) [Spigot](https://www.spigotmc.org/resources/68956/)       |

| 1488      | Free  | BungeeEssentials     | Multiple Essential Functions you might need, all in one Plugin                                                 | [Github](https://github.com/pantherman594/BungeeEssentials) [Spigot](https://www.spigotmc.org/resources/1488/)       |
#### Main Server: Lobby, Creative, Minigames
This Server Hosts the Lobby, Creative World and Minigames. It is separated, because some Plugins change Vanilla Behaviour.
AntiCooldown also disables Sweeping Edge and Quake might crash the Server.

It runs on Paper because it is Resource friendly.

##### Plugin List

| Spigot ID | Price               | Name                      | Description                                                                                       | Links                                                                                                                                           |
|:---------:| ------------------- | ------------------------- | ------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| 1166      | Free                | HubThat                   | Manages the Server-Hub, the welcome Area for joining Players                                      | [Mind Overflow](https://git.mind-overflow.net/Spigot/HubThat/) [Spigot](https://www.spigotmc.org/resources/hubthat.1166/)                       |
| 28140     | Free                | LuckPerms                 | Manages Permissions                                                                               | [Github](https://github.com/lucko/LuckPerms) [Spigot](https://www.spigotmc.org/resources/28140/)                                                |
| 390       | Free                | Multiverse-Core           | Allows Multi-World-Configuration, needed to load Custom Worlds and not load Vanilla-Worlds        | [Github](https://github.com/Multiverse/Multiverse-Core) [Spigot](https://www.spigotmc.org/resources/390/)                                       |
| 1997      | Free                | ProtocolLib               | Library Plugin used by Simple Voice Chat                                                          | [Github](https://github.com/Multiverse/Multiverse-Core) [Spigot](https://www.spigotmc.org/resources/390/)                                       |
| 6245      | Free                | PlaceholderAPI            | Allows you to use Placeholder in nearly any Config-File                                           | [Github](https://github.com/PlaceholderAPI/PlaceholderAPI) [Spigot](https://www.spigotmc.org/resources/6245/)                                   |
| 7688      | Free                | Armor Stand Editor [dead] | Allows players in survival to easily edit Armorstand pose and attributes.                         | [Github](https://github.com/RypoFalem/ArmorStandEditor) [Spigot](https://www.spigotmc.org/resources/armor-stand-editor-dead.7688/)              |
| 13932     | Free                | Fast Async WorldEdit      | Allows large Scale World-Modifications, needed by PlotSquared                                     | [Github](https://github.com/IntellectualSites/FastAsyncWorldEdit) [Spigot](https://www.spigotmc.org/resources/13932/)                           |
| 25391     | Free, Closed Source | VoidGen                   | Multiverse-World-Generator generating Empty Worlds                                                | [Spigot](https://www.spigotmc.org/resources/voidgen.25391/)                                                                                     |
| 51321     | Free                | AntiCooldown              | Removes Hit-Cooldown of newer Minecraft Versions for faster PvP experience                        | [Github](https://github.com/YourGameSpace/AntiCooldown) [Spigot](https://www.spigotmc.org/resources/anticooldown-1-9-1-18.51321/)               |
| 63714     | Free                | Screaming Bedwars         | PvP GameMode in the Sky, Players are trying to destroy the Respawn-Block (Bed) of the other Teams | [Github](https://github.com/ScreamingSandals/BedWars) [Spigot](https://www.spigotmc.org/resources/63714/)                                       |
| 70616     | Free                | BackupOnEvent             | Automatically creates Backups and manages configured Storage-Space                                | [Github](https://github.com/enayet123/BackupOnEventPlugin) [Spigot](https://www.spigotmc.org/resources/backuponevent.70616/)                    |
| 71465     | Free                | ImageMap                  | Creates Map-Items displaying Image Files. Used for TV-Like Custom Signs                           | [Github](https://github.com/gorogoro-space/ImageMap) [Spigot](https://www.spigotmc.org/resources/71465/)                                        |
| 77506     | 15€                 | PlotSquared               | Manages User-Plots for Creative Building                                                          | [Github](https://github.com/IntellectualSites/PlotSquared/) [Spigot](https://www.spigotmc.org/resources/plotsquared-v6.77506/)                  |
| 93738     | Free                | Simple Voice Chat         | Proximity Voice-Chat, Requires Client Mod!                                                        | [Github](https://github.com/henkelmax/simple-voice-chat) [Spigot](https://www.spigotmc.org/resources/simple-voice-chat.93738/)                  |

Planned:

| Spigot ID | Price               | Name                      | Description                                                                                       | Links                                                                                                                                           |
|:---------:| ------------------- | ------------------------- | ------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| 45928     | 15€, Closed Source  | Quake                     | Fast paced Shooter-like Minigame with Powerups                                                    | [Spigot](https://www.spigotmc.org/resources/quake-highly-customizable-%E2%80%A2-db-support-%E2%80%A2-leaderboards-%E2%80%A2-bungee-mode.45928/) |
| 81702     | Free                | uSurvivalGames            | PvP GameMode on the Ground, with loot and a protection Period                                     | [Github](https://github.com/jerzean/UltimateSurvivalGames) [Spigot](https://www.spigotmc.org/resources/usurvivalgames.81702/)                   |
| 87226     | Free                | Walk in the Park          | Infinite Generating Parkour                                                                       | [Github](https://github.com/Efnilite/Walk-in-the-Park) [Spigot](https://www.spigotmc.org/resources/87226/)                                      |

#### Survival
This Game-Server hosts the Survival Map, with Advancements like Protecting your Builds, Teleporting to friendly Players and simple Economy in the Form of Chest-Shops.

My choice for the Survival Game Server Type was Spigot, which is a bit heavier on the resources compared to Paper. The Reason for this choice is because my Players had Problems using Game-Bugs which are Fixed in Paper (e.g. breaking Bedrock). However, you can configure Paper to allow these, but my Players still complained, so I switched back to Spigot, which does not fix any Vanilla Server Bugs.
TLDR: Players blame Paper for Things that might not exist.

##### Plugin List

| Spigot ID | Price | Name                      | Description                                                                                            | Links                                                                                                                              |
|:---------:| ----- | ------------------------- | ------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| 93738     | Free  | Simple Voice Chat         | Proximity Voice-Chat, Requires Client Mod!                                                             | [Github](https://github.com/henkelmax/simple-voice-chat) [Spigot](https://www.spigotmc.org/resources/simple-voice-chat.93738/)     |
| 1997      | Free  | ProtocolLib               | Library Plugin used by Simple Voice Chat                                                               | [Github](https://github.com/Multiverse/Multiverse-Core) [Spigot](https://www.spigotmc.org/resources/390/)                          |
| 70616     | Free  | BackupOnEvent             | Automatically creates Backups and manages configured Storage-Space                                     | [Github](https://github.com/enayet123/BackupOnEventPlugin) [Spigot](https://www.spigotmc.org/resources/backuponevent.70616/)       |
| 7688      | Free  | Armor Stand Editor [dead] | Allows players in survival to easily edit Armorstand pose and attributes.                              | [Github](https://github.com/RypoFalem/ArmorStandEditor) [Spigot](https://www.spigotmc.org/resources/armor-stand-editor-dead.7688/) |
| 9089      | Free  | EssentialsX               | Essential Commands like `/home` `/tpa`, etc.                                                           | [Github](https://github.com/EssentialsX/Essentials) [Spigot](https://www.spigotmc.org/resources/essentialsx.9089/)                 |
| 1884      | Free  | GriefPrevention           | Players can Protect flexible sized Plots using a golden Shovel                                         | [Github](https://github.com/TechFortress/GriefPrevention/) [Spigot](https://www.spigotmc.org/resources/griefprevention.1884/)      |
| 73997     | Free  | MoreMobHeads              | Player- and Mob-Heads, and Micro-Blocks traded from the wandering Trader                               | [Github](https://github.com/JoelGodOfwar/MoreMobHeads) [Spigot](https://www.spigotmc.org/resources/moremobheads.73997/)            |
| 34315     | Free  | Vault                     | Permissions, Chat, & Economy API to give plugins easy hooks into these systems, used for Economy only. | [Github](https://github.com/milkbowl/Vault) [Spigot](https://www.spigotmc.org/resources/34315/)                                    |
| 51856     | Free  | ChestShop                 | a simple system for making physical shops using signs and chests                                       | [Github](https://github.com/ChestShop-authors/ChestShop-3) [Spigot](https://www.spigotmc.org/resources/chestshop.51856/)           |
| 16708     | Free  | Daily Rewards             | Rewards the Player to stay active. Type `/reward` each Day to get in-game Currency                     | [Github](https://github.com/HalfloveJAR/Daily-Rewards) [Spigot](https://www.spigotmc.org/resources/daily-rewards.16708/)           |
| 92546     | Free  | Heart                     | Displays Life of Players below their Name.                                                             | [Github](https://github.com/PastaLaPate/Heart/) [Spigot](https://www.spigotmc.org/resources/heart.92546/)                          |
