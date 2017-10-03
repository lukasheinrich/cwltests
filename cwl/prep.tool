#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0

baseCommand: []

inputs:
  model: string

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/recast_phenoexample
  ShellCommandRequirement: {}

arguments:
- cd
- /code
- ;
- ./paramfromyaml.py
- --madgraph
- -f
- defaultparam.yml
- $(inputs.model)
- $(runtime.outdir)/param.dat

outputs:
  parameter_card:
    type: File
    outputBinding:
      glob: param.dat
