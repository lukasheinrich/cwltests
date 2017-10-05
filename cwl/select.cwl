#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis

inputs:
  inputfile: File  #FIXME, name based off of type/purpose of file
  region: string
  variations:
    type: string[]
    inputBinding:
      position: 10
      itemSeparator: ','

outputs:
  outputfile:  # FIXME, what is this?
    type: File
    outputBinding:
      glob: selection.root

baseCommand: select.py

arguments:
  - $(inputs.inputfile.path)
  - selection.root
  - $(inputs.region)
