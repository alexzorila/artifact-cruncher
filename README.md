# Artifact Cruncher 2
Crunch artifacts found in Forensic Triage Images to plaso format ready to ingest into Timesketch to enable searching and reporting.
* $MFT parsed separately using MFTECmd
* Remaning triage ZIP parsed using Plaso
* Output merged into .plaso file
* Optimized for usage with WSL2

## Prerequisites
* Ubuntu 22.04

## Usage
### Install
```
git clone https://github.com/alexzorila/artifact-cruncher2.git
cd artifact-cruncher2
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
* Plaso https://github.com/log2timeline/plaso
* Timesketch https://github.com/google/timesketch
