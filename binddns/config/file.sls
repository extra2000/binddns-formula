# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import BINDDNS with context %}

{{ BINDDNS.bind_config_file }}:
  file.managed:
    - source: salt://binddns/files/named.conf.jinja
    - template: jinja
    - context:
      BINDDNS: {{ BINDDNS }}

zone-lists:
  file.managed:
    - name: {{ BINDDNS.bind_config_rootdir }}/zones.conf
    - source: salt://binddns/files/zones.conf
    - user: root
    - group: {{ BINDDNS.group }}
    - mode: 0640

zone-files:
  file.recurse:
    - name: {{ BINDDNS.work_rootdir }}/data/zones
    - source: salt://binddns/files/zones
    - exclude_pat:
      - "*.example"
    - user: root
    - group: {{ BINDDNS.group }}
    - file_mode: 0640
    - dir_mode: 0750

bind-log-file:
  cmd.run:
    - name: |
        touch {{ BINDDNS.work_rootdir }}/data/named.run
        chown {{ BINDDNS.user }}:{{ BINDDNS.group }} {{ BINDDNS.work_rootdir }}/data/named.run
