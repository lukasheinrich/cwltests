#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis
  ShellCommandRequirement: {}

inputs:
  inputfile: File  #FIXME, name based off of type/purpose of file
  region: string
  variations:
    type: string
    default: nominal

outputs:
  outputfile:  # FIXME, what is this?
    type: File
    outputBinding:
      glob: selection.root

baseCommand: /bin/bash

arguments:
  - valueFrom: |
      source /usr/local/bin/thisroot.sh
      python /code/select.py $(inputs.inputfile.path) selection.root $(inputs.region) $(inputs.variations)
    prefix: -c

