#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0

baseCommand: []

inputs:
  paramcard: File
  events: int

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/recast_phenoexample
  ShellCommandRequirement: {}

arguments:
- cd
- /code
- ;
- ./steermadgraph.py
- proc.dat
- default_run.dat
- $(inputs.paramcard.path)
- $(runtime.outdir)/events.lhe
- -e
- $(inputs.events)

outputs:
  leshouchesevents:
    type: File
    outputBinding:
      glob: events.lhe
