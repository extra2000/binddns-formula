# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import BINDDNS with context %}

include:
  - ..config

{{ BINDDNS.service.name }}:
  service.running:
    - enable: true
    - reload: true
    - watch:
      - file: {{ BINDDNS.bind_config_file }}
      - file: zone-lists
      - file: zone-files
