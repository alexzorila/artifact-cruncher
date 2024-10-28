# Artifact Cruncher
Parse Velociraptor triage collection to Supertimeline on Windows. Environment built using WLS2 and Docker. Maintains compatibility with Windows filesystem. Optional ingest into local Splunk container. 

Tested with: `Windows 11`, `WSL2`, `Ubuntu 22.04 guest`, `Docker`, `Plaso`, `MFTECmd`, `Splunk 9.3`

## Installation
Navigate the `Windows` filesystem to a desired install directory. Launch `Ubuntu 22.04` terminal via `WSL2`and run one of the following code snippets as `root`.
> For WSL2 usage and Ubuntu installation see [WSL Cheat Sheet](#wsl-2-cheat-sheet).

### Quick Install
Install `parse` module only. Default option.
```
git clone https://github.com/alexzorila/artifact-cruncher.git
cd artifact-cruncher
chmod +x ./setup.sh
./setup.sh parse
```
### Full Install
Install both `parse` and `splunk` modules.
```
git clone https://github.com/alexzorila/artifact-cruncher.git
cd artifact-cruncher
chmod +x ./setup.sh
./setup.sh parse splunk
```

### Show Help
```
./setup.sh

Error   : No valid script arguments passed! Specify one or both to install corresponding module.
Options : 'parse', 'splunk'

Examples:
        - Install both   : ./setup.sh parse splunk
        - Install parser : ./setup.sh parse
        - Install splunk : ./setup.sh splunk
```

## Usage
<!---
### Collect
```
PS> .\velociraptor_sans_triage.exe
```
Docs: [Velociraptor](https://docs.velociraptor.app/docs/offline_triage/#offline-collections), [KAPE](https://ericzimmerman.github.io/KapeDocs/#!Pages%5C5.-gkape.md), [CyLR](https://github.com/orlikoski/CyLR?tab=readme-ov-file#examples)
-->

### Parse
```
WSL> parse -f DESKTOP-123.zip
```
Docs: [artifact-cruncher/parse](parse)

### Analyse
| Splunk        | Details |
|---------------|---------|
| CSV Ingest    | Copy CSV data to `./artifact-cruncher/splunk/splunk-data` |
| Web GUI       | http://localhost:8000 |
| Web Login     | `admin:Password!` |

Docs: [artifact-cruncher/splunk](https://github.com/alexzorila/artifact-cruncher/tree/main/splunk), [Splunk Quick Reference Guide](https://www.splunk.com/en_us/resources/splunk-quick-reference-guide.html)

## Docker Cheat Sheet
Using `WSL2` run one or more of the following `commands` to manage a Docker compose instance.
| Operation       | Command |
|-----------------|---------|
| Show running    |	`docker compose ps` |
| Stop	     	  |	`docker compose stop` |
| Restart	  |	`docker compose restart` |
| Execute         |	`docker compose exec` |
| Destroy         |	`docker compose down` |

Docs: [Docker Compose](https://docs.docker.com/reference/cli/docker/compose/)

## WSL 2 Cheat Sheet
Using Windows `Terminal` run one or more of the following `commands` to manage an Ubunt guest install.
| Operation                      | Command |
| -------------------------------|---------|
| List distro install options    | `wsl -l -o` |
| Install Ubuntu 22.04          | `wls --install Ubuntu-22.04` |
| List installed distros         | `wsl -l` |
| Restart all distros            | `wsl --shutdown` |
| Stop Ubuntu distr              | `wsl --terminate Ubuntu` |
| Uninstall Ubuntu distro        |  `wls --unregister Ubuntu` |

Docs: [WSL Basic Commands](https://learn.microsoft.com/en-us/windows/wsl/basic-commands)

## Previous Version
**Date**: `Jan 10, 2023`  
**About**: VM built using Vagrant and VirtualBox. Parse forensic triage images collected with CyLR, using MFTECmd and CDQR. Ingest into Splunk.  
**Reference**: https://github.com/alexzorila/artifact-cruncher-vagrant
