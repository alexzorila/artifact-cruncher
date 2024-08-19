# Artifact Cruncher Backend (Plaso) (MFTECmd)
Parse disk triage collection to supertimeline flat file from Windows Terminal using WSL2 and Docker. Intended to convert ZIP to Plaso and CSV. Output compatible with Timesketch or Splunk ingestion. Individually parse $MFT with MFTECmd and remaining artifacts with Plaso for speed.

* Data directory: `Windows file system`, `current directory`, `.zip`
* Tested on: `Windows 11, WSL2, Ubuntu 22.04 guest`

## Quick Install
From an `Ubuntu` guest inside `WSL2` on Windows 11 run the following code snippet as `root`.
```
git clone https://github.com/alexzorila/artifact-cruncher2.git
cd artifact-cruncher2/parse
chmod +x ./setup.sh
./setup.sh
```
For WSL2 usage and Ubuntu install see [Cheat Sheet](../README.md#wsl-2-cheat-sheet).

## Usage
### Launch WSL 2
From the `Windows File System` navigate to the zip file directory. Open the `WSL2` distribution in the `current directory`.

### Parse
```
parse -f DC_RLAB_local.zip
```

### Output
Plaso and CSV flat files will be created in the `same directory` tree as the zip file. Expect `15 to 45 minutes` parsing time, depending on the collection file size.

```
DC_RLAB_local.plaso
DC_RLAB_local.csv
```

## Resources
* MFTECmd https://github.com/EricZimmerman/MFTECmd
* Plaso https://github.com/log2timeline/plaso
* Artifact Cruncher https://github.com/alexzorila/artifact-cruncher
