#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0

baseCommand: []

inputs:
  lhefile: File
  events: int

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/recast_phenoexample
  ShellCommandRequirement: {}

arguments:
- cd
- /code
- ;
- ./steerpythia.py
- $(inputs.lhefile)
- $(runtime.outdir)/events.hepmc
- -e
- $(inputs.events)

outputs:
  hepmc:
    type: File
    outputBinding:
      glob: events.hepmc
