#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis

inputs:
  data_bkg_hists: File

outputs:
  workspace:
    type: File
    outputBinding:
      glob: workspace*combined*model.root

baseCommand: makews.py

arguments:
  - $(inputs.data_bkg_hists.path)
  - $(runtime.outdir)/workspace
  - $(runtime.outdir)/xml
