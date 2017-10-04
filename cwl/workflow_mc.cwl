#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  nevents:
    type: int[]
    # default: [200,200]
  mcname: string
  mcweight: float
  shapevars: string[]
  weightvariations:
    type: string[]
    #default:
    #  - nominal
    #  - weight_var1_up
    #  - weight_var1_dn


outputs:
  merged:
    type: File
    outputSource: merge_all_vars/merged

steps:
  read:
    run: generate.cwl
    in:
      type: mcname
      nevents: nevents
    scatter: nevents
    out: [ events ]

  merge:
    run: merge.cwl
    in: 
      histograms: read/events
    out: [merged]

  select_signal_shapevars:
    run: workflow_select_shape.cwl
    in:
      inputfile: merge/merged
      mcname: mcname
      mcweight: mcweight
      shapevar: shapevars
    out: [histogram]
    scatter: shapevar 

  select_signal:
    run: select.cwl
    in:
      inputfile: merge/merged
      region: { default: signal }
      variations: weightvariations
    out: [ outputfile ] 


  merge_shape:
    run: merge.cwl
    in:
      histograms: select_signal_shapevars/histogram
    out: [merged]

  select_signal_hist:
    run: histogram.cwl
    in:
      inputfile: select_signal/outputfile
      name: mcname
      weight: mcweight
      variations: weightvariations
    out: [histogram]

  merge_all_vars:
    run: merge.cwl
    in:
      histograms:
        - select_signal_hist/histogram
        - merge_shape/merged
    out: [merged]

