
ACCESS TOKEN DESCRIPTION
harbor-instance
ACCESS PERMISSIONS
Read, Write, Delete

To use the access token from your Docker CLI client:

1. Run docker login -u Domain

2. At the password prompt, enter the personal access token.
90dc75e1-6260-4da4-80c4-f8a535b52c34


Install kubectl binary with curl on Linux

    Download the latest release with the command:

    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    Note:

    To download a specific version, replace the $(curl -L -s https://dl.k8s.io/release/stable.txt) portion of the command with the specific version.

    For example, to download version v1.23.0 on Linux, type:

    curl -LO https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl

    Validate the binary (optional)

    Download the kubectl checksum file:

    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

    Validate the kubectl binary against the checksum file:

    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

    If valid, the output is:

    kubectl: OK

    If the check fails, sha256 exits with nonzero status and prints output similar to:

    kubectl: FAILED
    sha256sum: WARNING: 1 computed checksum did NOT match

    Note: Download the same version of the binary and checksum.

    Install kubectl
```
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```
    Note:

    If you do not have root access on the target system, you can still install kubectl to the ~/.local/bin directory:
```
    chmod +x kubectl
    mkdir -p ~/.local/bin
    mv ./kubectl ~/.local/bin/kubectl
    # and then append (or prepend) ~/.local/bin to $PATH
```
    Test to ensure the version you installed is up-to-date:
```
    kubectl version --client
```
    Or use this for detailed view of version:
```
    kubectl version --client --output=yaml    
```