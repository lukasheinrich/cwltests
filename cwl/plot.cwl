#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis

inputs:
  combined_model: File

outputs:
  prefit_report:
    type: File
    outputBinding:
      glob: prefit.pdf
  postfit_report:
    type: File
    outputBinding:
      glob: postfit.pdf


baseCommand: /bin/bash

arguments:
  - prefix: -c
    valueFrom: |
      hfquickplot write_vardef $(inputs.combined_model.path) combined nominal_vals.yml
      hfquickplot plot_channel $(inputs.combined_model.path) combined channel1 x nominal_vals.yml -c qcd,mc2,mc1,signal -o prefit.pdf
      hfquickplot fit $(inputs.combined_model.path) combined fitresults.yml
      hfquickplot plot_channel $(inputs.combined_model.path) combined channel1 x fitresults.yml -c qcd,mc2,mc1,signal -o postfit.pdf
