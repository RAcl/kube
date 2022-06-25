# Github Action for Kubernetes CLI

- Image based on debian11
- Fork from patoxs
- docker push redalvagui/kube:latest

## Usage

`.github/workflows/eks.yml`

```yaml
on: push
name: deploy
jobs:
  deploy:
    name: Deploy to cluster
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: deploy to cluster
      uses: RAcl/kube@main
      env:
        KUBE_CONFIG: ${{ secrets.KUBE_CONFIG_DATA }}
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_DEFAULT_REGION: ${{ secrets.AWS_DEFAULT_REGION }}
      with:
        args: set image --record deployment.apps/my-app app=${{ steps.build-image.outputs.IMAGE }} -n ${{ secrets.NAMESPACE }}
    - name: verify deployment
      uses: RAcl/kube@main
      env:
        KUBE_CONFIG: ${{ secrets.KUBE_CONFIG_DATA }}
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_DEFAULT_REGION: ${{ secrets.AWS_DEFAULT_REGION }}
      with:
        args: rollout status deployment.apps/my-app -n ${{ secrets.NAMESPACE }}
```

## Secrets

`KUBE_CONFIG_DATA` – **required**: A base64-encoded kubeconfig file with credentials for Kubernetes to access the cluster. You can get it by running the following command:

```bash
cat $HOME/.kube/config | base64
```
