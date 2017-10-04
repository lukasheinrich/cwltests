#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis

inputs:
  data_bkg_hists: File  #FIXME, name based off of type/purpose of file

outputs:
  workspace:
    type: Directory
    outputBinding:
      glob: workspace

baseCommand: /bin/bash

arguments:
  - prefix: -c
    valueFrom: |
      source /usr/local/bin/thisroot.sh
      python /code/makews.py $(inputs.data_bkg_hists.path) $(runtime.outdir)/workspace $(runtime.outdir)/xml
