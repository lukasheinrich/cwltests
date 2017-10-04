#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  all_bkg_mc_nevents:
    type: int[]
    default: [20000,20000,20000,20000,20000,20000,20000,20000]
  data_nevents:
    type: int[]
    default: [10000,10000,10000,10000,10000,10000,10000,10000,10000,10000]
  signal_nevents:
    type: int[]
    default: [20000,20000,20000,20000]
  signal_mcweight:
    type: float
    default: 0.0025
  mcnames:
    type: string[]
    default: [mc1, mc2]
  mcweights:
    type: float[]
    default: [0.01875, 0.0125]

outputs:
  hepdata_submission:
    type: File
    outputSource: hepdata/hepdata_submission
  prefit_report:
    type: File
    outputSource: plot/prefit_report
  postfit_report:
    type: File
    outputSource: plot/postfit_report

steps:
  all_bkg_mc:
    run: wflow_all_mc.cwl
    in:
      nevents: all_bkg_mc_nevents
      mcname: mcnames
      mcweight: mcweights
    out: [ merged ]

  data:
    run: workflow_data.cwl
    in:
      nevents: data_nevents
    out: [ merged ]

  signal:
    run: workflow_sig.cwl
    in:
      nevents: signal_nevents
      weight: signal_mcweight
    out: [ merged ]
      
  merge:
    run: merge.cwl
    in: 
      histograms: [ all_bkg_mc/merged, data/merged, signal/merged ]
    out: [merged]

  makews:
    run: makews.cwl
    in:
      data_bkg_hists: merge/merged
    out: [workspace]

  plot:
    run: plot.cwl
    in:
      combined_model: makews/workspace
    out: [prefit_report, postfit_report]

  hepdata:
    run: hepdata.cwl
    in:
      combined_model: makews/workspace
    out: [hepdata_submission]
