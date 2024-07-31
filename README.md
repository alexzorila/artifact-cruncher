# Auto SuperTimeline
Triage disk image to supertimeline. 
* $MFT parsed separately using MFTECmd
* Remaning triage ZIP parsed using Plaso
* Output merged into .plaso file
* Ready to import into Timesketch
* Optimized for usage with WSL2 by working inside the linux file system.

## Prerequisites
* Ubuntu 22.04

## Usage
### Setup environment
```
git clone https://github.com/alexzorila/autosupertimeline.git
cd autosupertimeline
./setup.sh
```
### Parse artifacts
```
parse -f MSEDGEWIN10.zip
```
### Output
```
Collection-DC_RLAB_local-2024-07-06T15_52_44Z_SansTriage.plaso
```
## Resources
* MFTECmd https://github.com/EricZimmerman/MFTECmd
* Plaso https://plaso.readthedocs.io/en/latest/index.html
