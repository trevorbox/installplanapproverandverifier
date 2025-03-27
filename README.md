# InstallPlan Approver and Verifier

An image for disconnected use (no pip) with the (operators-installer)[https://github.com/redhat-cop/helm-charts/tree/main/charts/operators-installer#disconnected-use] helm chart

```sh
export TAG="quay.io/trevorbox/installplanapproverandverifier:4.16.0" # replace with your tag

podman build -t $TAG . \
  --build-arg git_origin_url=$(git config --get remote.origin.url) \
  --build-arg git_revision=$(git rev-parse HEAD) \
  --build-arg base_image_digest=$(skopeo inspect --format "{{ .Digest }}" docker://quay.io/openshift/origin-cli:4.16) \
  --build-arg base_image_repository=quay.io/openshift/origin-cli \
  --build-arg base_image_tag=4.16 \
  --build-arg src_version=$(git rev-parse --abbrev-ref HEAD) \
  --build-arg created=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  --build-arg author_emails="myorg@example.com" \
  --build-arg build_host=$(uname -n) \
  --build-arg build_id="1"

podman login quay.io
podman push $TAG
```
