
cwlVersion: v1.0
class: Workflow
    
requirements:
  MultipleInputFeatureRequirement: {}
inputs: []
# runMinbSimuFinish : output=Pythia8MinbSimuFinish/outDS
outputs:
  outDS:
    type: string
    outputSource: Pythia8MinbSimuFinish/outDS

steps:
  Pythia8MinbSimulation:
    run: prun
    in:
        opt_exec:
          default: "Pythia8MinbSimulation.sh  %RNDM:100000 >& _Pythia8MinbSimulation.log "
        opt_args:
          default: " --nJobs 50  --maxAttempt 3  --memory 8192  --outputs Pythia8MinbSimu.outDS.tar  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  runMinbSimuFinish:
    run: prun
    in:
        opt_inDS: Pythia8MinbSimu/outDS
        opt_inDsType:
          default: Pythia8MinbSimu.outDS.tar
        opt_exec:
          default: "runMinbSimuFinish.sh  %RNDM:100000 %IN >& _runMinbSimuFinish.log "
        opt_args:
          default: " --maxAttempt 3  --outputs Pythia8MinbSimuFinish.outDS.txt  --nFilesPerJob=1 --forceStaged  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]
