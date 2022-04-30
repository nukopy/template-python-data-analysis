# Template for Data Analysis with Python

## Setup

1. Build Docker image with a command `make u` (takes few minutes)
2. Start Docker container on background with a command `make u`
3. Open development environment:
   - If you wanna develop on Jupyter Lab, open [http://127.0.0.1:8888/lab](http://127.0.0.1:8888/lab) on your browser
   - If you wanna develop on Visual Studio Code, press `cmd + shift + P` on Visual Studio Code and select **"Remote - Containers: Reopen in Container"**

```sh
# Build Docker image
make b

# Start Docker container on background
make u

# Stop & Remove Docker container
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
