# ts3exporter-container

[![Build Status](https://drone.adamkoro.com/api/badges/adamkoro/ts3exporter-container/status.svg)](https://drone.adamkoro.com/adamkoro/ts3exporter-container)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/adamkoro/ts3exporter)](https://hub.docker.com/r/adamkoro/ts3exporter)
[![Docker Pulls](https://img.shields.io/docker/pulls/adamkoro/ts3exporter)](https://hub.docker.com/r/adamkoro/ts3exporter)
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/adamkoro/ts3exporter)](https://hub.docker.com/r/adamkoro/ts3exporter)
[![Docker Stars](https://img.shields.io/docker/stars/adamkoro/ts3exporter)](https://hub.docker.com/r/adamkoro/ts3exporter)
[![GitHub](https://img.shields.io/github/license/adamkoro/ts3exporter-container)](https://github.com/adamkoro/ts3exporter-container)

Container for [ts3exporter](https://github.com/hikhvar/ts3exporter)

## Usage

### Container information

- Rootless container
  - **User ID:** 10000

- Exporter port
  - **Port:** 9189

### Environment Variables
| Variable | Description | Default |
|----------|-------------|---------|
| REMOTE | Teamspeak Server IP or Hostname | localhost |
| PORT | Teamspeak Server Query Port | 10011 |
| TS_USER | Teamspeak Server Query Username | serveradmin |
| TS_PASS | Teamspeak Server Query Password | password |

#### ts3exporter parameters
[Original ts3exporter parameters](https://github.com/hikhvar/ts3exporter#usage)
If you want to change the default parameters, you can do so by adding the parameters to the docker run command.
To customize default parameters in the container check [entrypoint.sh](entrypoint.sh) and customize it to your needs.

### Docker

```bash
docker run -d -e REMOTE=teamspeak -e PORT=10011 -e TS_USER=serveradmin -e TS_PASS=password  -p 9189:9189 docker.io/adamkoro/ts3exporter:latest
```
