#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis

inputs:
  inputfile: File  #FIXME, name based off of type/purpose of file
  weight: float
  name: string
  shapevar: string
  variations:
    type: string[]
    inputBinding:
      position: 5
      itemSeparator: ','

outputs:
  histogram:
    type: File
    outputBinding:
      glob: hist.root

baseCommand: histogram.py

arguments:
  - $(inputs.inputfile.path)
  - hist.root
  - $(inputs.name)_$(inputs.shapevar)
  - $(inputs.weight)
  - valueFrom: '{name}'
    position: 10
