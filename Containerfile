FROM docker.io/alpine:latest

COPY config/ansible.cfg /ansible.cfg
COPY config/requirements.yml /requirements.yml

RUN apk --update --no-cache upgrade
RUN apk add py3-pip openssh-client git vim curl wget yq sshpass buildah && \
    pip install ansible ansible-vault ara openshift yamllint requests
RUN ansible-galaxy collection install -r requirements.yml && \ 
    ansible-galaxy install newrelic.newrelic-infra

ENV ANSIBLE_CONFIG=/ansible.cfg
## Optional ARA configuration
# ENV ANSIBLE_CALLBACK_PLUGINS="$(python3 -m ara.setup.callback_plugins)"
# ENV ARA_API_CLIENT=http
# ENV ARA_API_SERVER="https://ara.example.com"
# ENV ARA_API_USERNAME=ara_user

# RUN python3 -m ara.setup.path
# RUN python3 -m ara.setup.plugins
# RUN python3 -m ara.setup.action_plugins
# RUN python3 -m ara.setup.callback_plugins
# RUN python3 -m ara.setup.env
# RUN python3 -m ara.setup.ansible
