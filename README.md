# AutoSuperTimeline
Parse artifacts found in Forensic Triage Images using Plaso and MFTECmd.

* VM built using Vagrant and VirtualBox
* Parse and ingest logs from forensic triage images collected with CyLR

## Prerequisites
* Ubuntu 22.04
* WSL2

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
vagrant destroy -f
```
## Resources
* MFTECmd https://github.com/EricZimmerman/MFTECmd
* Plaso https://plaso.readthedocs.io/en/latest/index.html
