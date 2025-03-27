ARG base_image_repository
ARG base_image_digest

FROM ${base_image_repository}@${base_image_digest}

ARG base_image_digest
ARG base_image_repository
ARG base_image_tag

# $(git config --get remote.origin.url)
ARG git_origin_url
# $(git rev-parse HEAD)
ARG git_revision
# $(git rev-parse --abbrev-ref HEAD)
# note: this is a a semver git tag typically
ARG src_version
# ${date -u +'%Y-%m-%dT%H:%M:%SZ'}
ARG created
# group emails of the team that supports this image
ARG author_emails
# the build host url
ARG build_host
# a unique id for the build of this image
ARG build_id

LABEL org.opencontainers.image.title=azp-agent \
    org.opencontainers.image.description="An InstallPlan Approver and Verifier Image for disconnected environments. For use with the operators-installer helm chart <https://github.com/redhat-cop/helm-charts/tree/main/charts/operators-installer#disconnected-use>." \
    org.opencontainers.image.source=${git_origin_url} \
    org.opencontainers.image.revision=${git_revision} \
    org.opencontainers.image.base.digest=${base_image_digest} \
    org.opencontainers.image.base.name=${base_image_repository}:${base_image_tag} \
    org.opencontainers.image.version=${src_version} \
    org.opencontainers.image.created=${created} \
    org.opencontainers.image.authors=${author_emails} \    
    com.example.org.context.build-host=${build_host} \
    com.example.org.context.build-id=${build_id}

USER 0

RUN python3 -m ensurepip --upgrade
RUN python3 -m pip install openshift-client semver==2.13.0 --index-url https://pypi.org/simple/ --extra-index-url https://pypi.org/simple/

USER 1001
