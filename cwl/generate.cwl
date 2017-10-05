#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis

inputs:
  type: string
  nevents: int

outputs:
  events:  # FIXME, what is this?
    type: File
    outputBinding:
      glob: output_one.root

baseCommand: generantuple.py

arguments:
  - $(inputs.type)
  - $(inputs.nevents)
  - output_one.root

