# Usage


### helm dependency update <folder_path>
### helm install <release_name> <folder_path>
### helm upgrade -f <folder_path>/values2.yaml <release_name> <folder_path>
### helm uninstall <release_name>


# Example Usage:

    helm uninstall redis  -n service-cloud --kubeconfig=/Users/deadman/Documents/cluster01.yaml
    helm list -n service-cloud --kubeconfig=/Users/deadman/Documents/cluster01.yaml
    helm upgrade --install redis redis -n service-cloud --kubeconfig=/Users/deadman/Documents/cluster01.yaml
