# Artifact Cruncher Collector (Velociraptor)

Build Windows disk triage collector based on Velociraptor and KapeFiles artifact selection.

## Usage
### Build Collector
Modify `collect`\\`conf`\\`spec_file.yaml` as needed to add or remove collection artifacts.  
Build `collector.exe` by running `collect`\\`build.cmd` from Windows Explorer or Terminal.

Docs: [Velociraptor](https://docs.velociraptor.app/knowledge_base/tips/automate_offline_collector/)

### Collect
```
PS (Admin)> .\collect\collect.exe
```
Docs: [Velociraptor](https://docs.velociraptor.app/docs/offline_triage/#offline-collections), [KAPE](https://ericzimmerman.github.io/KapeDocs/#!Pages%5C5.-gkape.md), [CyLR](https://github.com/orlikoski/CyLR?tab=readme-ov-file#examples)
