# Artifact Cruncher
Crunch artifacts found in Forensic Disk Triage Collections. Optionally ingest into a local Splunk instance to enable searching and reporting. Tested on: `Windows 11`, `WSL2`, `Ubuntu 22.04 guest`, `Docker`.

## Quick Install
From an `Ubuntu` guest inside `WSL2` on Windows 11 run the following code snippet as `root`.
```
git clone https://github.com/alexzorila/artifact-cruncher2.git
cd artifact-cruncher2
chmod +x ./setup.sh
./setup.sh
```
For WSL2 usage and Ubuntu install see [Cheat Sheet](https://github.com/alexzorila/artifact-cruncher2/tree/main?tab=readme-ov-file#manage-wsl2-cheat-sheet).

## Usage
### Parse
### Splunk

## Manage WSL2 Cheat Sheet
Using Windows `Terminal` run one or more of the following `commands` to manage an Ubunt guest install.
| Operation | Command |
| ----------|---------|
List available distros for install | `wsl -l -o`
Install Ubuntu distro | `wls --install Ubuntu`
List installed distros | `wsl -l`
Restart all distros | `wsl --shutdown`
Stop Ubuntu distro | `wsl --terminate Ubuntu`
Uninstall Ubuntu distro |  `wls --unregister Ubuntu`

## Disk Triage Collectors
* Velociraptor: https://docs.velociraptor.app/docs/offline_triage/
* KAPE: https://ericzimmerman.github.io/KapeDocs/#!Pages%5C5.-gkape.md
* CyLR: https://github.com/orlikoski/CyLR?tab=readme-ov-file#examples

## Resources
* MFTECmd https://github.com/EricZimmerman/MFTECmd
* Plaso https://github.com/log2timeline/plaso
* Timesketch https://github.com/google/timesketch
* Velociraptor https://github.com/Velocidex/velociraptor
* CyLR https://github.com/orlikoski/CyLR
* Splunk Free: https://docs.splunk.com/Documentation/Splunk/9.3.0/Admin/MoreaboutSplunkFree
