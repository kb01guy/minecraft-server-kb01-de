# Description
This Project aims to empower you in setting up your very own Server-Network using Docker, which can be started using `docker-compose up` inside this Directory.

I use this Repository to run my own Minecraft-Server at kB01.de.






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
### Container
To further configure your Server-Network, see
https://github.com/itzg/docker-bungeecord for mc-bungeecord and
https://github.com/itzg/docker-minecraft-server for other Services

### Plugins
The Server Proxy (default: BungeeCord) supports Plugins as well as the Game-Servers them selves.
The Docker Containers allows automatic Plugin-Downloads from spigotmc.org via the Variable `SPIGET_RESOURCES`, which contains a Comma separated List of Plugin-IDs.

This are the Plugins I use on the Proxy Server:

| ID    | Price | Name | Description | Source |
| 28140 | Free  |
| 241   | Free  |
| 1488  | Free  |
| 8695  | Free  |
| 9531  | Free  |
| 68956 | Free  |

This are the Plugins I use on the Game Servers:

| ID    | Price | Name | Description | Source | Servers |
| 71456 |
| 63714 |
| 6245  |
| 87226 |

| 34315 |
| 1997  |
| 93738 |
| 92546 |
| 9089  |
| 16708 |
| 51856 |
| 70616 |
| 7688  |
| 1884  |
| 73997 |

| 77506 |
| 93738 |
| 390   |
| 25391 |
| 327   |
| 70616 |

| 390   |
| 63714 |
| 45928 |
| 81702 |
| 6245  |
| 51321 |

### Servers
My choice for the Survival Game Server was Spigot, which is a bit heavier on the resources compared to Paper. The Reason for this choice is because my Players had Problems using Game-Bugs which are Fixed in Paper (e.g. breaking Bedrock). However, you can configure Paper to allow these, but my Players still complained, so I switched back to Spigot, which does not fix any Vanilla Server Bugs.
TLDR: Players blame Paper for Things that might not exist.

The other Game Servers rely completely on Plugin Codes, which drove the decision to use the fastest solution Paper.
