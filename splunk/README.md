# Artifact Cruncher Frontend (Splunk)
Docker based Splunk deployment ready to ingest CSV data. Intended to be used as a local application to proces Plaso SuperTimeline output. 
Selected for forensic investigations leveraging the SPL query language flexibility, visualization capability and dashboard creation.

* Data ingest directory: `/artifact-cruncher/splunk/splunk-data`
* Tested on: `Windows 11, WSL2, Ubuntu 22.04 guest`

## Quick Install
From an `Ubuntu 22.04` guest inside `WSL2` on Windows 11 run the following code snippet as `root`.
```
git clone https://github.com/alexzorila/artifact-cruncher.git
cd artifact-cruncher/splunk
chmod +x ./setup.sh
./setup.sh
```
For WSL2 usage and Ubuntu install see [Cheat Sheet](../README.md#wsl-2-cheat-sheet).

## Usage
Copy CSV data to `/artifact-cruncher/splunk/splunk-data` to be ingested into the local Docker Splunk deployment.
Access data via the Splung Web GUI.

| Description | Details |
|-------------|---------|
Web interface | http://localhost:8000
User:Pass | admin:Password!
Show data (SPL) | earliest=0

To reset the environment you can destroy the container using `docker compose down` and re-deploy by running `./setup.sh`.

## Docker container commands
| Operation   | Command |
|-------------|---------|
| Show running	|	docker compose ps |
| Stop			|	docker compose stop |
| Restart		|	docker compose restart |
| Execute		|	docker compose exec |
| Destroy		|	docker compose down |

## Gain interactive access as root
```
docker compose exec -u root splunk bash
```

## References
- https://github.com/alexzorila/artifact-cruncher-vagrant
- https://docs.splunk.com/Documentation/Splunk/9.3.0/Installation/DeployandrunSplunkEnterpriseinsideDockercontainers
- https://chatgpt.com/share/6402fae5-e8f9-45bc-8a67-6b109b6bbf71
- https://dfir-kev.medium.com/plaso-super-timelines-in-splunk-a563181a1da5
- https://docs.docker.com/reference/cli/docker/compose/
- https://stackoverflow.com/a/54213140

