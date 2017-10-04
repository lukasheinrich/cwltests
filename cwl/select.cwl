#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis
  InlineJavascriptRequirement: {}

inputs:
  inputfile: File  #FIXME, name based off of type/purpose of file
  region: string
  variations:
    type: string[]
    # default: [ nominal ]

outputs:
  outputfile:  # FIXME, what is this?
    type: File
    outputBinding:
      glob: selection.root

baseCommand: /bin/bash

arguments:
  - prefix: -c
    valueFrom: |
      source /usr/local/bin/thisroot.sh
      python /code/select.py $(inputs.inputfile.path) selection.root $(inputs.region) ${
         var list="";
         var variationsLength = inputs.variations.length;
         console.log(variationsLength);
         for (var i = 0; i < variationsLength; i++) {
           list += inputs.variations[i];
           if (i < variationsLength - 1) {
             list = list +",";
           }
         }
         return list; }

