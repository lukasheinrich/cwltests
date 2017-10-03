#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: lukasheinrich/dummyanalysis
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: input_list
        entry: |
          ${ var list = "";
             inputs.histograms.forEach(function(value)  {
               list += value.path + '\n';
               });
             return list; }
  ShellCommandRequirement: {}

inputs:
  histograms: File[]

outputs:
  merged:
    type: File
    outputBinding:
      glob: merged.root

baseCommand: /bin/bash

arguments:
  - valueFrom: |
      source /usr/local/bin/thisroot.sh
      cat $(runtime.outdir)/input_list | xargs hadd merged.root
    prefix: -c

