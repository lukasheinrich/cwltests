#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis
  ShellCommandRequirement: {}

inputs:
  type: string
  nevents: int

outputs:
  events:  # FIXME, what is this?
    type: File
    outputBinding:
      glob: output_one.root

baseCommand: /bin/bash

arguments:
  - valueFrom: |
      source /usr/local/bin/thisroot.sh
      python /code/generantuple.py $(inputs.type) $(inputs.nevents) output_one.root
    prefix: -c

