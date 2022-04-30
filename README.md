# Template for Data Analysis with Python

## Setup

1. Build the Docker image with the command `make b` (takes few minutes)
2. Start the Docker container on background with the command `make u`
3. Open the development environment:
   - If you wanna develop on Jupyter Lab, open [http://127.0.0.1:8888/lab](http://127.0.0.1:8888/lab) on your browser
   - If you wanna develop on Visual Studio Code, press `cmd + shift + P` on Visual Studio Code and select **"Remote - Containers: Reopen in Container"**
4. Stop & Remove the Docker container with the command `make d`

```sh
# 1. Build the Docker image
make b

# 2. Start the Docker container on background
make u

# 4. Stop & Remove the Docker container
make d
```

## [WIP] Softwares

### For Network Analysis

- Python Library
  - NetworkX
  - graph-tool
  - igraph (CAUTION: [`pip` and `conda` have different installation methods](https://igraph.org/python/tutorial/latest/install.html#installing-igraph-via-conda)）
- GUI Tools
  - Gephi (on macOS, you can install it with Homebrew)
