#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis
  ShellCommandRequirement: {}

inputs:
  inputfile: File  #FIXME, name based off of type/purpose of file
  weight: float
  name: string
  variations:
    type: string
    default: nominal

outputs:
  histogram:
    type: File
    outputBinding:
      glob: hist.root

baseCommand: /bin/bash

arguments:
  - valueFrom: |
      source /usr/local/bin/thisroot.sh
      python /code/histogram.py $(inputs.inputfile.path) hist.root $(inputs.name) $(inputs.weight) $(inputs.variations)
    prefix: -c

