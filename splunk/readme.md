# Splunk Frontend
Docker based Splunk deployment ready to ingest CSV data. Intended to be used as a local application to proces Plaso SuperTimeline output. 
Selected for forensic investigations leveraging the SPL query language flexibility, visualization capability and dashboard creation.

* Data ingest directory: `/artifact-cruncher2/splunk/splunk-data`
* Tested on: `Windows 11, WSL2, Ubuntu 22.04 guest`

# Quick Install
```
git clone https://github.com/alexzorila/artifact-cruncher2.git
cd artifact-cruncher2/splunk
chmod +x ./setup.sh
./setup.sh
```

# Usage
| Key | Value |
|---------------|---------|
Web interface | http://localhost:8000
User:Pass | admin:Password!
Data Ingest | /artifact-cruncher2/splunk/splunk-data
Show data (SPL) | * earliest=0

# Docker container commands
| Operation   | Command |
|-------------|---------|
| Show running	|	docker compose ps |
| Stop			|	docker compose stop |
| Restart		|	docker compose restart |
| Execute		|	docker compose exec |
| Destroy		|	docker compose down |

# Gain interactive access as root
```
docker compose exec -u root splunk bash
```

# References
- https://github.com/alexzorila/artifact-cruncher
- https://docs.splunk.com/Documentation/Splunk/9.3.0/Installation/DeployandrunSplunkEnterpriseinsideDockercontainers
- https://dfir-kev.medium.com/plaso-super-timelines-in-splunk-a563181a1da5
- https://docs.docker.com/reference/cli/docker/compose/
- https://stackoverflow.com/a/54213140

