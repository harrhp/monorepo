FROM python:3.12-slim

RUN pip install --no-cache-dir ansible-core==2.16.3
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get install -y openssh-client && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean
RUN groupadd --gid 1000 ansible \
  && useradd --no-log-init --create-home --gid ansible --uid 1000 ansible \
  && mkdir -p /home/ansible/.ssh \
  && chmod 700 /home/ansible/.ssh \
  && chown -R ansible:ansible /home/ansible/.ssh

USER ansible
WORKDIR /home/ansible

COPY --chown=ansible:ansible ./ansible.cfg ./
RUN --mount=type=bind,source=./galaxy.yaml,target=/tmp/galaxy.yaml \
  ansible-galaxy install -r /tmp/galaxy.yaml

COPY --chown=ansible:ansible ./entrypoint.sh ./

ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "ansible", "--version" ]
