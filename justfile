set shell := ["/usr/bin/env", "bash", "-euo", "pipefail", "-c"]

[private]
default:
	@just --list

clean:
  nh clean all

build:
  nh home build .

switch:
  nh home switch .

update:
  nh home switch --update --ask .
