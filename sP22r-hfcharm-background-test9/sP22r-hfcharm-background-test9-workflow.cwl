
cwlVersion: v1.0
class: Workflow
    
requirements:
  MultipleInputFeatureRequirement: {}
inputs: []
# FinishMinbSimu : output=FinishPythia8MinbSimu/outDS
outputs:
  outDS:
    type: string
    outputSource: FinishPythia8MinbSimu/outDS

steps:
  Pythia8MinbSimulation:
    run: prun
    in:
        opt_exec:
          default: "Pythia8MinbSimulation.sh  %RNDM:100 >& _Pythia8MinbSimulation.log "
        opt_args:
          default: " --nJobs 100  --maxAttempt 3  --memory 8192  --maxWalltime 48  --cpuTimePerEvent 75000  --outputs Pythia8MinbSimulation.outDS.tar  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  FinishMinbSimu:
    run: prun
    in:
        opt_inDS: Pythia8MinbSimulation/outDS
        opt_inDsType:
          default: Pythia8MinbSimulation.outDS.tar
        opt_exec:
          default: "FinishMinbSimu.sh  %RNDM:100 %IN >& _FinishMinbSimu.log "
        opt_args:
          default: " --maxAttempt 5  --outputs FiniahPythia8MinbSimu.outDS.txt  --nFilesPerJob=1 --forceStaged  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]
