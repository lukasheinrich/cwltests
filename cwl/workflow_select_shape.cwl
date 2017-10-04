#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  InlineJavascriptRequirement: {}
  StepInputExpressionRequirement: {}

inputs:
  inputfile: File
  mcname: string
  mcweight: float
  shapevar: string

outputs:
  histogram:
    type: File
    outputSource: hist/histogram

steps:
  select:
    run: select.cwl
    in:
      inputfile: inputfile
      region: { default: signal }
      variations:
        source: shapevar
        valueFrom: ${ return [ self ]; }
    out: [ outputfile ] 

  #select_merge:
  #  run: merge.cwl
  #  in: {}
  #  out: []

  hist:
    run: histogram_shape.cwl
    in:
      inputfile: select/outputfile
      name: mcname
      weight: mcweight
      shapevar: shapevar
      variations: { default: [ nominal ] }
    out: [histogram]

