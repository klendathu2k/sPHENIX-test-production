
cwlVersion: v1.0
class: Workflow
    
requirements:
  MultipleInputFeatureRequirement: {}
inputs: []
# FinishCharmSimu : output=FinishPythia8CharmSimu/outDS
outputs:
  outDS:
    type: string
    outputSource: FinishPythia8CharmSimu/outDS

steps:
  Pythia8CharmSimulation:
    run: prun
    in:
        opt_exec:
          default: "Pythia8CharmSimulation.sh  %RNDM:0 >& _Pythia8CharmSimulation.log "
        opt_args:
          default: " --nJobs 20  --maxAttempt 1  --memory 8192  --outputs Pythia8CharmSimulation.outDS.tar  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  FinishCharmSimu:
    run: prun
    in:
        opt_inDS: Pythia8CharmSimulation/outDS
        opt_inDsType:
          default: Pythia8CharmSimulation.outDS.tar
        opt_exec:
          default: "FinishCharmSimu.sh  %RNDM:0 %IN >& _FinishCharmSimu.log "
        opt_args:
          default: " --maxAttempt 5  --outputs FiniahPythia8CharmSimu.outDS.txt  --nFilesPerJob=1 --forceStaged  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]
