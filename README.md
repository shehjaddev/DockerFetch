# DockerFetch

A Bash script that provides a concise and colorful overview of your Docker environment, designed to make managing your Docker setup both efficient and visually engaging. Inspired by tools like Neofetch, DockerFetch aims to empower developers and system administrators with a quick, at-a-glance view of their Docker ecosystem.

## Motivation

I created DockerFetch for personal use to simplify monitoring my Docker setup. Tired of running multiple commands to check containers, images, and resources, I wanted a single, visually appealing tool to display key info quickly. Inspired by Neofetch, DockerFetch saves time and makes Docker management fun with emoji-driven output.

## Description

DockerFetch is a lightweight script that displays key information about your Docker setup, including:

- Docker version and status
- Host information
- Container counts (running, stopped, total)
- Image counts and sizes
- Docker Compose projects
- Active port mappings
- Top container statistics
- Detailed container list

## Features

- Colorful terminal output with emoji indicators
- Checks if Docker is running
- Displays system information (hostname, uptime)
- Summarizes container and image status
- Shows recent images and active port mappings
- Lists running containers with details (ID, name, image, ports, runtime, status)

## Requirements

- Bash shell
- Docker installed and running
- Basic Unix utilities (`awk`, `grep`, `cut`, `sort`, `uniq`)

## Installation

1. Clone or download the repository:
   ```bash
   git clone https://github.com/yourusername/dockerfetch.git
   ```
2. Make the script executable:
   ```bash
   chmod +x dockerfetch.sh
   ```
3. To run the script by typing `dockerfetch` from any directory, add its directory to your PATH in `~/.bashrc`:
   - Add the following line to `~/.bashrc` (replace `~/dockerfetch` with the actual path to your script's directory):
     ```bash
     export PATH="$PATH:~/dockerfetch"
     ```
   - Reload the shell configuration:
     ```bash
     source ~/.bashrc
     ```

## Usage

Run the script using either:

```bash
./dockerfetch.sh
```

Or, after updating `~/.bashrc`:

```bash
dockerfetch
```

The script will output a formatted summary of your Docker environment to the terminal.

## Example Output

```
🐳  DockerFetch v1.0  |  Host: my-host  |  Uptime: 2 days

🔧 Docker:   ✅ Running | v20.10.17 | linux/x86_64 | Root: /var/lib/docker

📦 Containers       : 3 running / 2 stopped / 5 total
🧊 Images           : 10 total (2 dangling)
📁 Compose Projects : 2
💾 Image Size       : 5.2GB
🕓 Recent Image     : my-app:latest (2 days ago)
🔀 Port Mappings    : 4

💻 Docker Processes :
   CONTAINER ID  NAME            IMAGE           PORTS                CREATED       STATUS
   abc123        web-app         nginx:latest    0.0.0.0:80->80/tcp   2 days ago    Up 2 days
   def456        db              mysql:8.0       3306/tcp             3 days ago    Up 3 days
```

## Contributing

Contributions are welcome! Please submit a pull request or open an issue on GitHub to help improve DockerFetch.

## License

This project is licensed under the MIT License.