#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis

inputs:
  combined_model: File

outputs:
  hepdata_submission:
    type: File
    outputBinding:
      glob: submission.zip

baseCommand: /bin/bash

arguments:
  - prefix: -c
    valueFrom: |
      source /usr/local/bin/thisroot.sh
      python /code/hepdata_export.py $(inputs.combined_model.path)
      zip submission.zip submission.yaml data1.yaml
