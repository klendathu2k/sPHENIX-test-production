
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
# step count = 0
  top1:
    run: prun
    in:
        opt_exec:
          default: "top1.sh  %RNDM:0 >& _top1.log "
        opt_args:
          default: " --nJobs 1  --maxAttempt 1  --outputs top1outDS.tar  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

# step count = 1
  top2:
    run: prun
    in:
        opt_exec:
          default: "top2.sh  %RNDM:0 >& _top2.log "
        opt_args:
          default: " --nJobs 1  --maxAttempt 1  --outputs top2outDS.tar  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

# step count = 2
  bottom:
    run: prun
    in:
        opt_inDS: top1/outDS
        opt_inDsType:
          default: top1outDS.tar
        opt_secondaryDSs: [top2/outDS]
        opt_secondaryDsTypes:
          default: [top2outDS.tar]
        opt_exec:
          default: "bottom.sh  %RNDM:0 %IN %IN2 >& _bottom.log "
        opt_args:
          default: " --maxAttempt 1  --outputs results.root  --nFilesPerJob=1 --secondaryDSs IN2:1:%{DS1} --forceStaged  --forceStagedSecondary  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]
