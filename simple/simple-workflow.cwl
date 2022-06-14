
cwlVersion: v1.0
class: Workflow
    
requirements:
  MultipleInputFeatureRequirement: {}
inputs: []
# bottom : output=bottom/outDS
outputs:
  outDS:
    type: string
    outputSource: bottom/outDS

steps:
  top:
    run: prun
    in:
        opt_exec:
          default: "top.sh  %RNDM:0 >& _top.log "
        opt_args:
          default: " --nJobs 3  --maxAttempt 1  --outputs seed.txt  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  bottom:
    run: prun
    in:
        opt_inDS: top/outDS
        opt_inDsType:
          default: seed.txt
        opt_exec:
          default: "bottom.sh  %RNDM:0 %IN >& _bottom.log "
        opt_args:
          default: " --maxAttempt 1  --outputs results.root  --nFilesPerJob=1 --forceStaged  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]
