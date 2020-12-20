# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import BINDDNS with context %}

{{ BINDDNS.pkg.name }}:
  pkg.installed
