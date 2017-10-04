#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis
  InlineJavascriptRequirement: {}

inputs:
  inputfile: File  #FIXME, name based off of type/purpose of file
  weight: float
  name: string
  shapevar: string
  variations:
    type: string[]
    default: [ "nominal" ]

outputs:
  histogram:
    type: File
    outputBinding:
      glob: hist.root

baseCommand: /bin/bash

arguments:
  - prefix: -c
    valueFrom: |
      source /usr/local/bin/thisroot.sh
      python /code/histogram.py $(inputs.inputfile.path) hist.root $(inputs.name)_$(inputs.shapevar) $(inputs.weight) ${
        var list="";
        var variationsLength = inputs.variations.length;
        console.log(variationsLength);
        for (var i = 0; i < variationsLength; i++) {
          list += inputs.variations[i];
          if (i < variationsLength - 1) {
            list = list +",";
          }
        }
        return list; } {name}
