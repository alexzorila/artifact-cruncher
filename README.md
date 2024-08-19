# Artifact Cruncher v2
Crunch artifacts found in Forensic Triage Images to Plaso format ready for Timesketch ingestion. Script optimised for ease of use and speed.
* $MFT parsed separately using MFTECmd
* Remaining Triage ZIP parsed using Plaso
* Output merged into .plaso file and CSV
* Optimized for usage with WSL2

## Prerequisites
* Ubuntu 22.04
* Forensic Triage Image

## Usage
### Install
```
git clone https://github.com/alexzorila/artifact-cruncher2.git
cd artifact-cruncher2
chmod +x ./setup.sh
./setup.sh
```
### Parse artifacts
```
parse -f DC_RLAB_local-2024-07-06T15_52_44Z_SansTriage.zip
```
### Output
```
Collection-DC_RLAB_local-2024-07-06T15_52_44Z_SansTriage.plaso
Collection-DC_RLAB_local-2024-07-06T15_52_44Z_SansTriage.csv
```
## Collect Triage Image
* Velociraptor: https://docs.velociraptor.app/docs/offline_triage/
* KAPE: https://ericzimmerman.github.io/KapeDocs/#!Pages%5C5.-gkape.md
* CyLR: https://github.com/orlikoski/CyLR?tab=readme-ov-file#examples

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

## Resources
* MFTECmd https://github.com/EricZimmerman/MFTECmd
* Plaso https://github.com/log2timeline/plaso
* Timesketch https://github.com/google/timesketch
* Velociraptor https://github.com/Velocidex/velociraptor
* CyLR https://github.com/orlikoski/CyLR
